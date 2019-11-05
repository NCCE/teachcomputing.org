class CsAcceleratorEnrolmentTransitionJob < ApplicationJob
  queue_as :default

  def perform(user, meta)
    enrolment = user.user_programme_enrolments.find_by(programme_id: Programme.cs_accelerator.id)
    enrolment.transition_to(:complete, meta)
  end
end