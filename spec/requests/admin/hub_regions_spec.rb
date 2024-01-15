require "rails_helper"

RSpec.describe "Admin::HubRegionsController" do
  let(:hub_region) { create(:hub_region) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  describe "GET #index" do
    before do
      get admin_hub_regions_path
    end

    it "should render correct template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_hub_region_path(hub_region)
    end

    it "should render correct template" do
      expect(response).to render_template("show")
    end
  end

  describe "PUT #update" do
    before do
      put admin_hub_region_path(hub_region, params: {
        hub_region: {name: "test"}
      })
    end

    it "should redirect to the show page" do
      expect(response).to redirect_to(admin_hub_region_path(hub_region))
    end
  end
end
