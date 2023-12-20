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

  def pending
    PrimaryMailer.with(user: User.first).pending
  end

  def completed_cpd_not_activities
    PrimaryMailer.with(user: User.first).completed_cpd_not_activities
  end
end
