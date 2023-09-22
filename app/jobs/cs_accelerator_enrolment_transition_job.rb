class CSAcceleratorEnrolmentTransitionJob < ApplicationJob
  queue_as :default

  def perform(user, meta)
    enrolment = user.user_programme_enrolments.find_by(programme_id: Programme.cs_accelerator.id)
    enrolment.transition_to(:complete, meta)

    # Secondary requires CSA to be completed, and we want to try and move it
    # into pending once they complete their class marker test
    CertificatePendingTransitionJob.perform_now(Programme.secondary_certificate, user.id, meta: { source: 'CSAcceleratorEnrolmentTransitionJob.perform' })
  end
end
