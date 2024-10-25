class EnrolmentConfirmationComponentPreview < ViewComponent::Preview
  def default
    render(EnrolmentConfirmationComponent.new(
      current_user: User.last.presence,
      programme: Programme.primary_certificate,
      full_width: false
    ))
  end

  def full_width
    render(EnrolmentConfirmationComponent.new(
      current_user: User.last.presence,
      programme: Programme.primary_certificate
    ))
  end

  def custom_button_text
    render(EnrolmentConfirmationComponent.new(
      current_user: User.last.presence,
      programme: Programme.primary_certificate,
      full_width: false,
      button_text: "Click here to enrol"
    ))
  end
end
