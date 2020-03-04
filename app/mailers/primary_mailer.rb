class PrimaryMailer < ApplicationMailer
  def completed
    @user = params[:user]
    @programme = Programme.primary_certificate
    @subject = 'Congratulations you have completed the National Centre for Computing Education Certificate in Primary Computing Teaching'

    mail(to: @user.email, subject: @subject)
  end
end
