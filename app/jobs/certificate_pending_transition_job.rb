class CertificatePendingTransitionJob < ApplicationJob
  queue_as :default

  def perform(user, meta = {}, programmes: [Programme.i_belong, Programme.secondary_certificate, Programme.primary_certificate])
    programmes.each do |programme|
      next unless programme&.user_meets_completion_requirement?(user)

      enrolment = user.user_programme_enrolments.find_by(programme_id: programme.id)

      next unless enrolment.present?
      next if enrolment&.current_state == :complete.to_s

      enrolment.transition_to(:pending, meta)
      ScheduleCertificateCompletionJob.set(wait: programme.pending_delay).perform_later(enrolment)
    end
  end
end
