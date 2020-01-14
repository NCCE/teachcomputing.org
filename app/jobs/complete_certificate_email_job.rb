class CompleteCertificateEmailJob < ApplicationJob
  queue_as :default

  def perform(user, programme)
    CertificateMailer.with(user: user,
                           programme: programme).completed.deliver_now
  end
end
