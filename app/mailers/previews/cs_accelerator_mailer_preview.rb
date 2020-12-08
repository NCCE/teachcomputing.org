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

  def new_assessment_eligibility
    CsAcceleratorMailer.with(user: User.first).new_assessment_eligibility
  end

  def non_enrolled_csa_user
    SentEmail.where(user_id: User.first.id,
                    mailer_type: CsAcceleratorMailer::CSA_NON_ENROLLED_USER_EMAIL)
             .destroy_all
    CsAcceleratorMailer.with(user: User.first).non_enrolled_csa_user
  end

  def auto_enrolled_welcome
    SentEmail.where(user_id: User.first.id,
                    mailer_type: CsAcceleratorMailer::CSA_AUTO_ENROLLED_WELCOME)
             .destroy_all
    CsAcceleratorMailer.with(user: User.first).auto_enrolled_welcome
  end
end
