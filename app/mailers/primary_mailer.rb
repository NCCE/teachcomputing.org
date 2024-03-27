class PrimaryMailer < ApplicationMailer
  def enrolled
    @user = params[:user]
    @programme = Programme.primary_certificate
    @subject = "Welcome to Teach primary computing"

    mail(to: @user, subject: @subject)
  end

  def completed
    @user = params[:user]
    @programme = Programme.primary_certificate
    @subject = "Congratulations you have completed the Teach primary computing certificate from the National Centre for Computing Education"

    mail(to: @user, subject: @subject)
  end

  def inactive_prompt
    @user = params[:user]
    @programme = Programme.primary_certificate
    @subject = "Kick-start your development and achieve a national qualification"

    mail(to: @user, subject: @subject)
  end

  def pending
    @user = params[:user]
    @programme = Programme.primary_certificate
    @subject = "Well done - you’ve completed Teach primary computing and we’re checking your activities"

    mail(to: @user, subject: @subject)
  end

  def completed_cpd_not_activities
    @user = params[:user]
    @programme = Programme.primary_certificate
    @subject = "You're so close!"

    mail(to: @user, subject: @subject)
  end

  def auto_enrolled
    @user = params[:user]
    @subject = "Welcome to Teach primary computing"

    mail(to: @user, subject: @subject)
  end
end
