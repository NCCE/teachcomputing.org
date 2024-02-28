class CertificatePendingTransitionJob < ApplicationJob
  queue_as :default

  def perform(user, meta = {}, programmes: [Programme.i_belong, Programme.secondary_certificate, Programme.primary_certificate, Programme.a_level])
    programmes.each do |programme|
      next unless programme&.user_meets_completion_requirement?(user)

      enrolment = user.user_programme_enrolments.find_by(programme_id: programme.id)

      next if enrolment.blank?
      next if enrolment&.current_state == :complete.to_s

      enrolment.transition_to(:pending, meta)

      if programme.pending_delay
        ScheduleCertificateCompletionJob.set(wait: programme.pending_delay).perform_later(enrolment)
      else
        enrolment.transition_to(:complete)
      end
    end
  end
end
