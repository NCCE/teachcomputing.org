require "rails_helper"

RSpec.describe "Admin::BadgesController" do
  let(:badge) { create(:badge) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  describe "GET #index" do
    before do
      get admin_badges_path
    end

    it "should render correct template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_badge_path(badge)
    end

    it "should render correct template" do
      expect(response).to render_template("show")
    end
  end

  describe "PUT #update" do
    before do
      put admin_badge_path(badge, params: {
        badge: {active: false}
      })
    end

    it "should redirect to the show page" do
      expect(response).to redirect_to(admin_badge_path(badge))
    end
  end
end
