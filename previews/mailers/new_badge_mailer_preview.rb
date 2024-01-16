class NewBadgeMailerPreview < ActionMailer::Preview
  def new_badge_email
    user = User.first
    NewBadgeMailer.with(preview: true).new_badge_email(user, Programme.first)
  end
end
