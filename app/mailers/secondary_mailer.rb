class SecondaryMailer < ApplicationMailer
  def welcome
    @user = params[:user]
    @subject = 'Welcome to Teach secondary computing'

    mail(to: @user, subject: @subject)
  end

  def completed
    @user = params[:user]
    @subject = 'Congratulations you have completed the National Centre for Computing Education Certificate in Secondary Computing Teaching'

    mail(to: @user, subject: @subject)
  end

  def pending
    @user = params[:user]
    @subject = 'Well done - you’ve completed Teach secondary computing and we’re checking your activities'

    mail(to: @user, subject: @subject)
  end
end
