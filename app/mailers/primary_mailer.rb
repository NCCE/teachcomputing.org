class PrimaryMailer < ApplicationMailer
  def completed
    @user = params[:user]
    @programme = Programme.primary_certificate

    mail(to: @user.email, subject: "Congratulations you have completed the National Centre for Computing Education Certificate in Primary Computing Teaching")
  end
end
