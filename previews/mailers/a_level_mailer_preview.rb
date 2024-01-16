class ALevelMailerPreview < ActionMailer::Preview
  def welcome
    ALevelMailer.with(user: User.first, preview: true).welcome
  end

  def completed
    ALevelMailer.with(user: User.first, preview: true).completed
  end
end
