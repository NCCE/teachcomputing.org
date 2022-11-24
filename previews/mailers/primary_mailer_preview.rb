class PrimaryMailerPreview < ActionMailer::Preview
  def enrolled
    PrimaryMailer.with(user: User.first).enrolled
  end

  def completed
    PrimaryMailer.with(user: User.first).completed
  end
end
