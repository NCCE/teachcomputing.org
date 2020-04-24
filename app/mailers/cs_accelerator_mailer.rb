class CsAcceleratorMailer < ApplicationMailer
  def completed
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = 'Congratulations you have completed the National Centre for Computing Education Certificate in GCSE Computing Subject Knowledge'

    mail(to: @user.email, subject: @subject)
  end


	def assesment_eligibility
  	@user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = "Congratulations #{@user.first_name.to_s}, you are now eligible to take the CS Accelerator test and receive your certificate."

    mail(to: @user.email, subject: @subject)
  end

  def new_assesment_eligibility
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = "Congratulations #{@user.first_name.to_s}, you are now eligible to take the CS Accelerator test and receive your certificate."

    mail(to: @user.email, subject: @subject)
  end
end
