class CertificateMailerPreview < ActionMailer::Preview
  def completed
    CertificateMailer.with(user: User.first, programme: Programme.cs_accelerator).completed
  end
end
