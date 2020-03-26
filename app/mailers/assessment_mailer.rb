class AssessmentMailer < ApplicationMailer
  def failed
    @user = User.find(params[:user])
    @subject = 'Unfortunately your assessment was unsuccessful'

    mail(to: @user.email, subject: @subject)
  end
end
