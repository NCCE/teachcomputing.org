class CompletedDashBadgeComponentPreview < ViewComponent::Preview
  def default
    component_email = "completed-dash-badge-component@example.com"
    component_stem_user_id = "completed-dash-badge-component"

    user = User.find_by(email: component_email, stem_user_id: component_stem_user_id) || FactoryBot.create(:user, email: component_email, stem_user_id: component_stem_user_id)

    badge = Badge.last
    credly_badge = Credly::Badge.by_programme_badge_template_ids(user.id, badge.credly_badge_template_id, preview: true)

    render(CompletedDashBadgeComponent.new(badge: credly_badge, tracking_event_category: "Test", tracking_event_label: "Test"))
  end
end
