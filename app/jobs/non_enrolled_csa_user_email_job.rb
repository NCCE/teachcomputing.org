class NonEnrolledCSAUserEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    return if SentEmail.mailer_type_for_user(user, CsAcceleratorMailer::CSA_NON_ENROLLED_USER_EMAIL).any?

    CsAcceleratorMailer.with(user: user).non_enrolled_csa_user.deliver_now
  end
end
