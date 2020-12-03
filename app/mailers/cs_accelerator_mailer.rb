class CsAcceleratorMailer < ApplicationMailer
  CSA_COMPLETED_EMAIL = 'csa_completed_email'.freeze
  CSA_ASSESSMENT_ELIGIBILITY_EMAIL = 'csa_assessment_eligibility_email'.freeze
  CSA_NON_ENROLLED_USER_EMAIL = 'csa_non_enrolled_user_email'.freeze
  CSA_MANUAL_ENROLLED_WELCOME = 'csa_manual_enrolled_welcome_email'.freeze

  def completed
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = 'Congratulations you have completed the National Centre for Computing Education Certificate in GCSE Computing Subject Knowledge'

    mail(to: @user.email, subject: @subject)
  end

  def assessment_eligibility
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = "#{@user.first_name} your CS Accelerator test is ready."

    mail(to: @user.email, subject: @subject, record_sent_mail: true, mailer_type: CSA_ASSESSMENT_ELIGIBILITY_EMAIL)
  end

  def new_assessment_eligibility
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = "#{@user.first_name} your CS Accelerator test is ready."

    mail(to: @user.email, subject: @subject)
  end

  def manual_enrolled_welcome
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = 'Welcome to the Computer Science Accelerator'

    mail(to: @user.email, subject: @subject, record_sent_mail: true, mailer_type: CSA_MANUAL_ENROLLED_WELCOME)
  end

  def non_enrolled_csa_user
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = 'Time to finish what you’ve started and achieve your qualification'

    mail(to: @user.email, subject: @subject, record_sent_mail: true, mailer_type: CSA_NON_ENROLLED_USER_EMAIL)
  end
end
