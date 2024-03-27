class ScheduleCertificateCompletionJob < ApplicationJob
  queue_as :default

  def perform(enrolment, meta = {})
    return unless enrolment.in_state?(:pending)
    return unless enrolment.last_transition.created_at <= (enrolment.programme.pending_delay.ago + 30.minutes)

    enrolment.transition_to(:complete, meta)
  end
end
