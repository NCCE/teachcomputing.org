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

  def non_enrolled_csa_user
    CsAcceleratorMailer.with(user: User.first).non_enrolled_csa_user
  end
end
