class ALevelMailer < ApplicationMailer
  before_action :assign_user

  def completed
    @subject = "Congratulations on your achievement #{@user.full_name}"

    mail(to: @user, subject: @subject)
  end

  def welcome
    @subject = 'Welcome to A level subject knowledge!'

    mail(to: @user, subject: @subject)
  end

  private

    def assign_user
      @user = params[:user]
    end
end
