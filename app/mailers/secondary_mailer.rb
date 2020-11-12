class SecondaryMailer < ApplicationMailer
  def welcome
    @user = params[:user]
    @subject = 'Welcome to Teach secondary computing'

    mail(to: @user.email, subject: @subject)
  end
end
