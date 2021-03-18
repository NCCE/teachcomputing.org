class NewAssessmentEligibilityJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    programme = Programme.cs_accelerator

    return unless programme.enough_activities_for_test?(user)

    CSAcceleratorMailer.with(user: user).new_assessment_eligibility.deliver_now
  end
end
