class CertificatePendingTransitionJob < ApplicationJob
  queue_as :default

  def perform(programme, user_id, meta)
    user = find_user(user_id)
    return unless programme&.user_meets_completion_requirement?(user)

    enrolment = user.user_programme_enrolments.find_by(programme_id: programme.id)

    return unless enrolment.present?
    return if enrolment&.current_state == :complete.to_s

    enrolment.transition_to(:pending, meta)
    ScheduleCertificateCompletionJob.set(wait: programme.pending_delay).perform_later(enrolment)
  end

  private

    def find_user(user_id)
      User.find(user_id)
    end
end
