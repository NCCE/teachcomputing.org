class NonEnrolledCSAUserEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    # To be enabled once email content received
    # CsAcceleratorMailer.with(user: user).non_enrolled_csa_user.deliver_now
  end
end
