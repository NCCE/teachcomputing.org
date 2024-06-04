class CpdCourseComponentPreview < ViewComponent::Preview
  def default
    component_email = "cpd-course-component@example.com"
    component_stem_user_id = "cpd-course-component"
    user = User.find_by(email: component_email, stem_user_id: component_stem_user_id)

    if user.blank?
      user = FactoryBot.create(:user, email: component_email, stem_user_id: component_stem_user_id)
      FactoryBot.create(:achievement, user: user, activity: Activity.last)
    end

    render(CpdCourseComponent.new(current_user: user, activity: user.activities.last, last_margin: false))
  end
end
