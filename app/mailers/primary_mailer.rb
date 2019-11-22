class PrimaryMailer < ApplicationMailer

  def completed
    @user = params[:user]
    @programme = params[:programme]
    mail to: @user.email
  end
end
