class CompleteCertificateEmailJob < ApplicationJob
  queue_as :default

  def perform(user, programme)
    programme.mailer.with(user: user).completed.deliver_now
  end
end
