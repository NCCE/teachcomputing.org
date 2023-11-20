class PrimaryMailer < ApplicationMailer
  def enrolled
    @user = params[:user]
    @programme = Programme.primary_certificate
    @subject = 'Welcome to Teach primary computing'

    mail(to: @user, subject: @subject)
  end

  def completed
    @user = params[:user]
    @programme = Programme.primary_certificate
    @subject = 'Congratulations you have completed the National Centre for Computing Education Certificate in Primary Computing Teaching'

    mail(to: @user, subject: @subject)
  end

  def inactive_prompt
    @user = params[:user]
    @programme = Programme.primary_certificate
    @subject = 'Kick-start your development and achieve a national qualification'

    mail(to: @user, subject: @subject)
  end
end
