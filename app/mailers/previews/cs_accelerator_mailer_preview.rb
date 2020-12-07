class CsAcceleratorMailerPreview < ActionMailer::Preview
  def completed
    CsAcceleratorMailer.with(user: User.first).completed
  end

  def assessment_eligibility
    CsAcceleratorMailer.with(user: User.first).assessment_eligibility
  end

  def new_assessment_eligibility
    CsAcceleratorMailer.with(user: User.first).new_assessment_eligibility
  end

  def manual_enrolled_welcome
    SentEmail.where(user_id: User.first.id, mailer_type: CsAcceleratorMailer::CSA_MANUAL_ENROLLED_WELCOME).destroy_all
    CsAcceleratorMailer.with(user: User.first).manual_enrolled_welcome
  end
end
