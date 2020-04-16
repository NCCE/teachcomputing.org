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
    @subject = 'You can now take final exam. Congrats'

    mail(to: @user.email, subject: @subject)
	end
end
