class CommunityActivityListComponentPreview < ViewComponent::Preview
  def default
    component_email = "community-activity-list-component@example.com"
    component_stem_user_id = "community-activity-list-component"

    user = User.find_by(email: component_email, stem_user_id: component_stem_user_id) || FactoryBot.create(:user, email: component_email, stem_user_id: component_stem_user_id)

    community_achievements = FactoryBot.build_list(:achievement, 5, :community, user: user)
    programme = Programme.find_by(slug: "i-belong")
    programme_activity_grouping = programme.programme_activity_groupings.last

    render(CommunityActivityListComponent.new(
      programme_activity_grouping: programme_activity_grouping,
      community_achievements: community_achievements,
      tracking_category: "test",
      number_to_show: 5
    ))
  end
end
