class CompleteCertificateEmailJob < ApplicationJob
  queue_as :default

  def perform(user, programme)
    case programme.slug
    when 'cs-accelerator'
      CsAcceleratorMailer.with(user: user).completed.deliver_now
    when 'primary-certificate'
      PrimaryMailer.with(user: user).completed.deliver_now
    end
  end
end
