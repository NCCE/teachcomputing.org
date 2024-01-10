class ScheduleCertificateCompletionJob < ApplicationJob
  queue_as :default

  def perform(enrolment, meta = {})
    certificate_number = enrolment.programme.programme_complete_counter.get_next_number
    enrolment.transition_to(:complete, meta.merge({certificate_number: certificate_number}))
  end
end
