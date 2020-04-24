class CsAcceleratorMailerPreview < ActionMailer::Preview
  def completed
    CsAcceleratorMailer.with(user: User.first).completed
  end

  def assesment_eligibility
    CsAcceleratorMailer.with(user: User.first).assesment_eligibility
  end

  def new_assesment_eligibility
    CsAcceleratorMailer.with(user: User.first).new_assesment_eligibility
  end
end
