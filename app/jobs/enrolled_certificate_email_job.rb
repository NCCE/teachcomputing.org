class EnrolledCertificateEmailJob < ApplicationJob
  queue_as :default

  def perform(user, programme)
    case programme.slug
    when 'cs-accelerator'
      CSAcceleratorMailer.with(user: user).enrolled.deliver_now
    when 'primary-certificate'
      PrimaryMailer.with(user: user).enrolled.deliver_now
    when 'secondary-certificate'
      SecondaryMailer.with(user: user).enrolled.deliver_now
    end
  end
end
