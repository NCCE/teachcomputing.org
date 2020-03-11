class AssesmentEligibilityJob < ApplicationJob
  queue_as :default

  def perform(user, programme)
    CsAcceleratorMailer.with(user: user).assesment_eligibility.deliver_now
  end
end
