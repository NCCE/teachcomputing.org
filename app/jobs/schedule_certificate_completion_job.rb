class ScheduleCertificateCompletionJob < ApplicationJob
  queue_as :default

  def perform(enrolment, meta = {})
    return unless enrolment.in_state?(:pending)

    if enrolment.last_transition.created_at <= (DateTime.now - enrolment.programme.pending_delay)
      enrolment.transition_to(:complete, meta)
    end
  end
end
