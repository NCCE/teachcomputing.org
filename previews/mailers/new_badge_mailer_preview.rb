class NewBadgeMailerPreview < ActionMailer::Preview
  def new_badge_email
    user = User.first
    NewBadgeMailer.new_badge_email(user, Programme.first)
  end
end
