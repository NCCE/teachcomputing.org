require "rails_helper"

RSpec.describe("certificates/i_belong/show", type: :view) do
  let(:user) { create(:user) }
  let(:i_belong) { create(:i_belong) }
  let(:professional_development_groups) { create_list(:programme_activity_grouping, 1, :with_activities, sort_key: 2, programme: i_belong) }
  let(:online_development_group) { create(:programme_activity_grouping, :with_activities, sort_key: 3, programme: i_belong) }
  let(:community_groups) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 4, programme: i_belong) }
  let(:community_activity) { create(:activity, :community) }

  before do
    stub_course_templates
    stub_duration_units

    assign(:programme, i_belong)

    assign(:current_user, user)

    assign(:face_to_face_achievements, [])
    assign(:online_achievements, [])

    assign(:professional_development_groups, professional_development_groups)
    assign(:cpd_courses, professional_development_groups.flat_map(&:programme_activities))
    assign(:online_discussion_activity, community_activity)
    assign(:community_groups, community_groups)

    render
  end

  it "has the hero" do
    expect(rendered).to have_css(".hero__heading", text: i_belong.title)
  end

  it "has correct list setup" do
    expect(rendered).to have_css(".ncce-activity-list--programme", count: 3)
  end

  it "has a community activity component" do
    expect(rendered).to have_css(".community-activity-component")
  end

  it "has the expected section titles" do
    expect(rendered).to have_text("Understand the factors affecting girls' participation in computer science")
    expect(rendered).to have_text("A group name", count: 2)
  end

  it "has no recommendation list" do
    expect(rendered).not_to have_css(".recommended-courses-wrapper", text: "Courses based on your pathway")
  end

  it "shows all activities" do
    expect(rendered).to have_css(".ncce-activity-list__item", count: 3)
  end

  it "shows no hidden activity title" do
    expect(rendered).not_to have_text("View more activity options")
  end

  it "has support information" do
    expect(rendered).to have_css(".aside-component__heading", text: "Need some help?")
  end

  it "has feedback form" do
    expect(rendered).to have_css(".feedback-component__heading", text: "What can we do better?")
  end
end
