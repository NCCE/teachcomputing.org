class ProgressBarComponentPreview < ViewComponent::Preview
  def default
    component_email = "progress-bar-component@example.com"
    component_stem_user_id = "progress-bar-component"

    user = User.find_by(email: component_email, stem_user_id: component_stem_user_id)

    if user.blank?
      user = FactoryBot.create(:user, email: component_email, stem_user_id: component_stem_user_id)
      programme = Programme.find_by(slug: "primary-certificate")

      FactoryBot.create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id)
    end

    render(ProgressBarComponent.new(user, user.programmes.first, title: "Progress Bar Component"))
  end
end
