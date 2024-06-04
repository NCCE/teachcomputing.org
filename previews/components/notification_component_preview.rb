class NotificationComponentPreview < ViewComponent::Preview
  def default
    component_email = "notification-component@example.com"
    component_stem_user_id = "notification-component"

    user = User.find_by(email: component_email, stem_user_id: component_stem_user_id)

    if user.blank?
      user = FactoryBot.create(:user, email: component_email, stem_user_id: component_stem_user_id)
      programme = Programme.find_by(slug: "subject-knowledge")

      FactoryBot.create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id)
    end

    render(NotificationComponent.new(user: user, preview: true))
  end
end
