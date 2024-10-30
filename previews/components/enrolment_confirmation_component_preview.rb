class EnrolmentConfirmationComponentPreview < ViewComponent::Preview
  layout "two-thirds"

  def default
    render(EnrolmentConfirmationComponent.new(
      current_user: User.last,
      programme: Programme.primary_certificate
    ))
  end

  def full_width_false
    render(EnrolmentConfirmationComponent.new(
      current_user: User.last,
      programme: Programme.primary_certificate,
      full_width: false
    ))
  end

  def custom_button_text
    render(EnrolmentConfirmationComponent.new(
      current_user: User.last,
      programme: Programme.primary_certificate,
      full_width: false,
      button_text: Faker::Lorem.words(number: 4)
    ))
  end

  def user_not_logged_in
    render(EnrolmentConfirmationComponent.new(
      current_user: nil,
      programme: Programme.primary_certificate,
      full_width: false
    ))
  end
end
