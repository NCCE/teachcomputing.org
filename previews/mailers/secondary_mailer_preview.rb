class SecondaryMailerPreview < ActionMailer::Preview
  def welcome
    SecondaryMailer.with(user: User.first).welcome
  end

  def completed
    SecondaryMailer.with(user: User.first).completed
  end

  def pending
    SecondaryMailer.with(user: User.first).pending
  end

  def inactive_prompt
    SecondaryMailer.with(user: User.first).inactive_prompt
  end

  def completed_cpd_not_activities
    SecondaryMailer.with(user: User.first).completed_cpd_not_activities
  end
end
