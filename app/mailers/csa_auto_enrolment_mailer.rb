class CSAAutoEnrolmentMailer < ApplicationMailer
  def welcome
    @user = params[:user]
    @subject = 'Kick-start your CPD with our Computer Science Accelerator programme'

    mail(to: @user.email, subject: @subject)
  end
end
