class PathwayEnrolComponentPreview < ViewComponent::Preview
  def default
    component_email = "pathway-enrol-component@example.com"
    component_stem_user_id = "pathway-enrol-component"

    user = User.find_by(email: component_email, stem_user_id: component_stem_user_id) || FactoryBot.create(:user, email: component_email, stem_user_id: component_stem_user_id)

    programme = Programme.find_by(slug: "primary-certificate")
    pathway = programme.pathways.last

    render(PathwayEnrolComponent.new(programme: programme, pathway: pathway, current_user: user))
  end
end
