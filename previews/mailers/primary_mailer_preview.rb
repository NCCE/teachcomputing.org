class PrimaryMailerPreview < ActionMailer::Preview
  def enrolled
    PrimaryMailer.with(user: User.first).enrolled
  end

  def completed
    PrimaryMailer.with(user: User.first).completed
  end

  def inactive_prompt
    PrimaryMailer.with(user: User.first).inactive_prompt
  end 
end
