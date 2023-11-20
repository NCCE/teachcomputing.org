class IBelongMailer < ApplicationMailer
  before_action :assign_user

  def completed
    @subject = "Congratulations on your achievement #{@user.full_name}"

    mail(to: @user, subject: @subject)
  end

  def pending
    @subject = 'Thank you for participating in the I Belong programme'

    mail(to: @user, subject: @subject)
  end

  def welcome
    @subject = 'Welcome to I Belong: Encouraging girls into computer science!'

    mail(to: @user, subject: @subject)
  end

  private

    def assign_user
      @user = params[:user]
    end
end
