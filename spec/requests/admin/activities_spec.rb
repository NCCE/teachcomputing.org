require "rails_helper"

RSpec.describe "Admin::ActivitiesController" do
  let(:activity_replaced_by) { create(:activity) }
  let(:activity) { create(:activity, :stem_learning, credit: 10, replaced_by: activity_replaced_by) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  describe "GET #index" do
    before do
      get admin_activities_path
    end

    it "should render correct template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_activity_path(activity)
    end

    it "should render correct template" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    before do
      get edit_admin_activity_path(activity)
    end

    it "should render correct template" do
      expect(response).to render_template("edit")
    end
  end

  describe "PUT #update" do
    before do
      put admin_activity_path(activity, params: {
        activity: {provider: "system", credit: " "}
      })
    end

    it "should redirect to the correct view" do
      expect(response).to redirect_to(admin_activity_path(activity))
    end

    it "should not update values passed in as blank" do
      activity.reload
      expect(activity.credit).not_to eq(" ")
    end
  end
end
