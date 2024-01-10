require "rails_helper"

RSpec.describe "Admin root request spec" do
  context "when authenticated with CF access" do
    it "redirects to the pathway index route" do
      allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")

      get admin_root_path

      expect(response).to have_http_status(:ok)
    end

    it "asks client not to cache potentially sensitive pages" do
      allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")

      get admin_root_path

      expect(response.headers["cache-control"]).to eq("no-store")
    end
  end

  context "without CF access authentication" do
    it "redirects to the root of the application" do
      get admin_root_path

      expect(response).to redirect_to(root_path)
    end
  end
end
