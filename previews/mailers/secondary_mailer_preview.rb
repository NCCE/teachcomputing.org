class SecondaryMailerPreview < ActionMailer::Preview
  def enrolled
    SecondaryMailer.with(user: User.first, preview: true).enrolled
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

  def auto_enrolled
    SecondaryMailer.with(user: User.first, preview: true).auto_enrolled
  end
end
