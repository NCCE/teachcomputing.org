class NewBadgeMailer < ApplicationMailer
  def new_badge_email
    @user = params[:user]
    @programme = Programme.find_by!(slug: params[:slug])
    @subject = 'You’ve been awarded a new digital badge'

    mail(to: @user.email, subject: @subject)
  end
end
