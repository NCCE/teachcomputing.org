class CSAcceleratorMailerPreview < ActionMailer::Preview
  def completed
    CSAcceleratorMailer.with(user: User.first, preview: true).completed
  end

  def assessment_eligibility
    SentEmail.where(user_id: User.first.id,
      mailer_type: CSAcceleratorMailer::CSA_ASSESSMENT_ELIGIBILITY_EMAIL)
      .destroy_all
    CSAcceleratorMailer.with(user: User.first, preview: true).assessment_eligibility
  end

  def getting_started_prompt
    user = User.first
    enrolment = UserProgrammeEnrolment.find_or_create_by(user: user, programme: Programme.cs_accelerator)
    SentEmail.where(user_id: User.first.id,
      mailer_type: CSAcceleratorMailer::CSA_GETTING_STARTED_PROMPT_EMAIL)
      .destroy_all
    CSAcceleratorMailer.with(user: user, enrolment_id: enrolment.id, preview: true).getting_started_prompt
  end

  def manual_enrolled_welcome
    SentEmail.where(user_id: User.first.id, mailer_type: CSAcceleratorMailer::CSA_MANUAL_ENROLLED_WELCOME).destroy_all
    CSAcceleratorMailer.with(user: User.first, preview: true).manual_enrolled_welcome
  end

  def auto_enrolled_welcome
    SentEmail.where(user_id: User.first.id,
      mailer_type: CSAcceleratorMailer::CSA_AUTO_ENROLLED_WELCOME)
      .destroy_all
    CSAcceleratorMailer.with(user: User.first, preview: true).auto_enrolled_welcome
  end
end
