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
end
