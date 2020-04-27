class NewAssessmentEligibilityJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    programme = Programme.cs_accelerator

    enrolment = user.user_programme_enrolments.find_by(programme_id: programme.id)

    return if enrolment.nil? || enrolment.current_state == :complete.to_s

    return unless programme.enough_activites_for_test?(user)

    CsAcceleratorMailer.with(user: user).new_assessment_eligibility.deliver_now
  end
end
