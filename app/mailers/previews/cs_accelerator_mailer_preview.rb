class CsAcceleratorMailerPreview < ActionMailer::Preview
  def completed
    CsAcceleratorMailer.with(user: User.first).completed
  end
end
