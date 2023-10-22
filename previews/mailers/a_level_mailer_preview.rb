class ALevelMailerPreview < ActionMailer::Preview
  def welcome
    ALevelMailer.with(user: User.first).welcome
  end

  def completed
    ALevelMailer.with(user: User.first).completed
  end
end
