class AssessmentMailer < ApplicationMailer
  def failed
    @user = User.find(params[:user_id])
    @subject = "Unfortunately your assessment was unsuccessful"

    mail(to: @user, subject: @subject)
  end
end
