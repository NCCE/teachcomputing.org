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

  def inactive_not_completed_any_sections
    IBelongMailer.with(user: User.first).inactive_not_completed_any_sections
  end

  def inactive_only_completed_one_section
    IBelongMailer.with(user: User.first).inactive_only_completed_one_section
  end

  def inactive_everything_but_understanding_factors
    IBelongMailer.with(user: User.first).inactive_everything_but_understanding_factors
  end

  def inactive_everything_but_access_resources
    IBelongMailer.with(user: User.first).inactive_everything_but_access_resources
  end

  def inactive_everything_but_increase_engagement
    IBelongMailer.with(user: User.first).inactive_everything_but_increase_engagement
  end
end
