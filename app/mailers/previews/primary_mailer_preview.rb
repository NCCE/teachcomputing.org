class PrimaryMailerPreview < ActionMailer::Preview
  def completed
    PrimaryMailer.with(user: User.first).completed
  end
end
