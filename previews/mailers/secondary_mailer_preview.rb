class SecondaryMailerPreview < ActionMailer::Preview
  def welcome
    SecondaryMailer.with(user: User.first, preview: true).welcome
  end

  def completed
    SecondaryMailer.with(user: User.first, preview: true).completed
  end

  def pending
    SecondaryMailer.with(user: User.first, preview: true).pending
  end

  def inactive_prompt
    SecondaryMailer.with(user: User.first, preview: true).inactive_prompt
  end

  def completed_cpd_not_activities
    SecondaryMailer.with(user: User.first, preview: true).completed_cpd_not_activities
  end
end
