require "rails_helper"

RSpec.describe "Admin::ProgrammeActivityGroupingsController" do
  let(:programme_activity_grouping) do
    create(:programme_activity_grouping,
      web_copy: {
        course_requirements: "Complete this section",
        aside_slug: "test-slug",
        subtitle: "Complete the activities in this section",
        step_number: "three"
      })
  end

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  describe "GET #index" do
    before do
      get admin_programme_activity_groupings_path
    end

    it "should render correct template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_programme_activity_grouping_path(programme_activity_grouping)
    end

    it "should render correct template" do
      expect(response).to render_template("show")
    end
  end

  describe "PUT #update" do
    before do
      put admin_programme_activity_grouping_path(programme_activity_grouping, params: {
        programme_activity_grouping: {title: "test"}
      })
    end

    it "should redirect to the show page" do
      expect(response).to redirect_to(admin_programme_activity_grouping_path(programme_activity_grouping))
    end
  end
end
