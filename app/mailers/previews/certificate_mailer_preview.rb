class CertificateMailerPreview < ActionMailer::Preview
  def completed
    CertificateMailer.with(user: FactoryBot.create(:user), programme: FactoryBot.create(:programme) ).completed
  end
end
