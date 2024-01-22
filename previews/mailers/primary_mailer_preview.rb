class PrimaryMailerPreview < ActionMailer::Preview
  def enrolled
    PrimaryMailer.with(user: User.first, preview: true).enrolled
  end

  def completed
    PrimaryMailer.with(user: User.first, preview: true).completed
  end

  def inactive_prompt
    PrimaryMailer.with(user: User.first, preview: true).inactive_prompt
  end

  def pending
    PrimaryMailer.with(user: User.first, preview: true).pending
  end

  def completed_cpd_not_activities
    PrimaryMailer.with(user: User.first, preview: true).completed_cpd_not_activities
  end

  def auto_enrolled
    PrimaryMailer.with(user: User.first, preview: true).auto_enrolled
  end
end
