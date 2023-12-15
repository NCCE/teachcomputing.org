class SecondaryMailer < ApplicationMailer
  def welcome
    @user = params[:user]
    @subject = 'Welcome to Teach secondary computing'

    mail(to: @user, subject: @subject)
  end

  def completed
    @user = params[:user]
    @subject = 'Congratulations you have completed the Teach secondary computing certificate from the National Centre for Computing Education'

    mail(to: @user, subject: @subject)
  end

  def pending
    @user = params[:user]
    @subject = 'Well done - you’ve completed Teach secondary computing and we’re checking your activities'

    mail(to: @user, subject: @subject)
  end

  def inactive_prompt
    @user = params[:user]
    @subject = 'Kick-start your development and achieve a national qualification'

    mail(to: @user, subject: @subject)
  end

  def completed_cpd_not_activities
    @user = params[:user]
    @subject = 'You\'re so close!'

    mail(to: @user, subject: @subject)
  end
end
