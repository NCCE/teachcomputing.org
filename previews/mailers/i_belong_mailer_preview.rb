class IBelongMailerPreview < ActionMailer::Preview
  def welcome
    IBelongMailer.with(user: User.first).welcome
  end

  def pending
    IBelongMailer.with(user: User.first).pending
  end

  def completed
    IBelongMailer.with(user: User.first).completed
  end
end
