class ALevelMailerPreview < ActionMailer::Preview
  def enrolled
    ALevelMailer.with(user: User.first, preview: true).enrolled
  end

  def completed
    ALevelMailer.with(user: User.first, preview: true).completed
  end
end
