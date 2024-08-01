class NewBadgeMailer < ApplicationMailer
  def new_badge_email(user, programme)
    @user = user
    @programme = programme
    @subject = "You’ve been awarded a new digital badge"

    mail(to: @user, subject: @subject)
  end
end
