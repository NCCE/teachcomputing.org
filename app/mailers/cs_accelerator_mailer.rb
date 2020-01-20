class CsAcceleratorMailer < ApplicationMailer
  def completed
    @user = params[:user]
    @programme = Programme.cs_accelerator

    mail(to: @user.email, subject: "Congratulations you have completed the National Centre for Computing Education Certificate in GCSE Computing Subject Knowledge")
  end
end