class ScheduleCertificateCompletionJob < ApplicationJob
  queue_as :default

  def perform(enrolment, meta = {})
    enrolment.programme.set_user_programme_enrolment_complete_data(enrolment)

    certificate_number = enrolment.programme.programme_complete_counter.get_next_number
    enrolment.transition_to(:complete, meta.merge({ certificate_number: certificate_number }))
  end
end
