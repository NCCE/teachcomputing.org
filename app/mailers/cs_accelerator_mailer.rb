class CsAcceleratorMailer < ApplicationMailer
  def completed
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = 'Congratulations you have completed the National Centre for Computing Education Certificate in GCSE Computing Subject Knowledge'

    mail(to: @user.email, subject: @subject)
  end


	def assessment_eligibility
  	@user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = "#{@user.first_name.to_s} your CS Accelerator test is ready."

    mail(to: @user.email, subject: @subject)
  end

  def new_assessment_eligibility
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = "#{@user.first_name.to_s} your CS Accelerator test is ready."

    mail(to: @user.email, subject: @subject)
  end

  def non_enrolled_csa_user
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = 'Time to finish what you’ve started and achieve your qualification'

    mail(to: @user.email, subject: @subject)
  end
end
