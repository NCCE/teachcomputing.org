class AchievementMailer < ApplicationMailer
  def complete
    @user = User.find(params[:user_id])
    @activity = Activity.find(params[:activity_id])
    @subject = 'Congratulations on completing an activity'

    mail(to: @user.email, subject: @subject)
  end
end
