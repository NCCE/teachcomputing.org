require "rails_helper"

RSpec.describe("certificates/i_belong/show", type: :view) do
  let(:user) { create(:user) }
  let(:i_belong) { create(:i_belong) }
  let(:professional_development_groups) { create_list(:programme_activity_grouping, 1, :with_activities, sort_key: 2, programme: i_belong, title: "CPD Group Title") }
  let(:community_groups) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 4, programme: i_belong, web_copy_aside_slug: "i-belong-community-help") }

  before do
    stub_course_templates
    stub_duration_units
    stub_strapi_aside_section

    groups = professional_development_groups

    assign(:programme, i_belong)

    assign(:current_user, user)

    assign(:face_to_face_achievements, [])
    assign(:online_achievements, [])

    assign(:professional_development_groups, professional_development_groups)
    assign(:cpd_courses, groups.flat_map(&:programme_activities))
    assign(:cpd_group, groups.first)
    assign(:community_groups, community_groups)
    assign(:completed_comm_groups, [])
    assign(:incomplete_comm_groups, community_groups)

    render
  end

  context "All incomplete" do

    it "has the hero" do
      expect(rendered).to have_css(".hero__heading", text: i_belong.title)
    end

    it "has a community activity component" do
      expect(rendered).to have_css(".community-activity-component")
    end

    it "has the expected section titles" do
      expect(rendered).to have_text("CPD Group Title")
      expect(rendered).to have_text("A group name", count: 2)
    end

    it "has no recommendation list" do
      expect(rendered).not_to have_css(".recommended-courses-wrapper", text: "Courses based on your pathway")
    end

    it "renders CpdCourseListComponent" do
      expect(response).to have_css(".cpd-course-list")
    end

    it "shows no hidden activity title" do
      expect(rendered).not_to have_text("View more activity options")
    end

    it "should render 2 aside components" do
      expect(rendered).to have_css(".aside-component__heading", count: 3)
    end
  end
end
