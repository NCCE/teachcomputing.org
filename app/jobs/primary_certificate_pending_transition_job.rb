class PrimaryCertificatePendingTransitionJob < ApplicationJob
  queue_as :default

  def perform(user_id, meta)
    user = find_user(user_id)
    programme = Programme.primary_certificate
    return unless programme.user_meets_completion_requirement?(user)

    enrolment = user.user_programme_enrolments.find_by(programme_id: programme.id)
    return if enrolment.current_state == :complete.to_s
    
    enrolment.transition_to(:pending, meta)
    SchedulePrimaryCertificateCompletionJob.set(wait: 7.days).perform_later(enrolment)
  end

  private

    def find_user(user_id)
      User.find(user_id)
    end
end
