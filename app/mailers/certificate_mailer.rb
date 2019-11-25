class CertificateMailer < ApplicationMailer

  def completed
    @user = params[:user]
    @programme = params[:programme]
    mail(to: @user.email, subject: "Congratulations you have completed #{@programme.title}")
  end
end
