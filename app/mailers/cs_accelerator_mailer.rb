class CSAcceleratorMailer < ApplicationMailer
  helper :external_link

  CSA_COMPLETED_EMAIL = 'csa_completed_email'.freeze
  CSA_ASSESSMENT_ELIGIBILITY_EMAIL = 'csa_assessment_eligibility_email'.freeze
  CSA_GETTING_STARTED_PROMPT_EMAIL = 'csa_getting_started_prompt_email'.freeze
  CSA_MANUAL_ENROLLED_WELCOME = 'csa_manual_enrolled_welcome_email'.freeze
  CSA_AUTO_ENROLLED_WELCOME = 'csa_auto_enrolled_welcome_email'.freeze

  def completed
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = 'Congratulations you have completed the National Centre for Computing Education Certificate in GCSE Computing Subject Knowledge'

    mail(to: @user, subject: @subject)
  end

  def assessment_eligibility
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = "#{@user.first_name} your CS Accelerator test is ready."

    mail(to: @user, subject: @subject, record_sent_mail: true, mailer_type: CSA_ASSESSMENT_ELIGIBILITY_EMAIL)
  end

  def getting_started_prompt
    @user = params[:user]
    @enrolment_id = params[:enrolment_id]
    @subject = 'Kick-start your CPD and achieve a national qualification'

    mail(to: @user, subject: @subject, record_sent_mail: true, mailer_type: CSA_GETTING_STARTED_PROMPT_EMAIL)
  end

  def manual_enrolled_welcome
    @user = params[:user]
    @programme = Programme.cs_accelerator
    @subject = 'Welcome to our KS3 and GCSE Computer Science subject knowledge certificate'

    mail(to: @user, subject: @subject, record_sent_mail: true, mailer_type: CSA_MANUAL_ENROLLED_WELCOME)
  end

  def auto_enrolled_welcome
    @user = params[:user]
    @subject = 'Achieve your subject knowledge certificate with the Computer Science Accelerator'

    mail(to: @user, subject: @subject, record_sent_mail: true, mailer_type: CSA_AUTO_ENROLLED_WELCOME)
  end
end
