class CsAcceleratorMailerPreview < ActionMailer::Preview
  def completed
    CsAcceleratorMailer.with(user: User.first).completed
  end

  def assessment_eligibility
    SentEmail.where(user_id: User.first.id,
                    mailer_type: CsAcceleratorMailer::CSA_ASSESSMENT_ELIGIBILITY_EMAIL)
             .destroy_all
    CsAcceleratorMailer.with(user: User.first).assessment_eligibility
  end

  def getting_started_prompt
    user = User.first
    enrolment = UserProgrammeEnrolment.find_or_create_by(user: user, programme: Programme.cs_accelerator)
    SentEmail.where(user_id: User.first.id,
                    mailer_type: CsAcceleratorMailer::CSA_GETTING_STARTED_PROMPT_EMAIL)
             .destroy_all
    CsAcceleratorMailer.with(user: user, enrolment_id: enrolment.id).getting_started_prompt
  end

  def new_assessment_eligibility
    CsAcceleratorMailer.with(user: User.first).new_assessment_eligibility
  end

  def manual_enrolled_welcome
    SentEmail.where(user_id: User.first.id, mailer_type: CsAcceleratorMailer::CSA_MANUAL_ENROLLED_WELCOME).destroy_all
    CsAcceleratorMailer.with(user: User.first).manual_enrolled_welcome
  end

  def auto_enrolled_welcome
    SentEmail.where(user_id: User.first.id,
                    mailer_type: CsAcceleratorMailer::CSA_AUTO_ENROLLED_WELCOME)
             .destroy_all
    CsAcceleratorMailer.with(user: User.first).auto_enrolled_welcome
  end
end
