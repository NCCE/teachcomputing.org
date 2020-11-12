class SecondaryMailerPreview < ActionMailer::Preview
  def welcome
    SecondaryMailer.with(user: User.first).welcome
  end
end
