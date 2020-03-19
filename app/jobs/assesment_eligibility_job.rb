class AssesmentEligibilityJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    programme = Programme.cs_accelerator

    return unless programme.enough_activites_for_test?(user)

    enrolment = user.user_programme_enrolments.find_by(programme_id: programme.id)

    return if enrolment.current_state == :complete.to_s

    CsAcceleratorMailer.with(user: user).assesment_eligibility.deliver_now
  end
end
