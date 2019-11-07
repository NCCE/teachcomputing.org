class SchedulePrimaryCertificateCompletionJob < ApplicationJob
  queue_as :default

  def perform(enrolment)
    certificate_number = enrolment.programme.programme_complete_counter.get_next_number
    enrolment.transition_to(:complete, certificate_number: certificate_number)
  end
end
