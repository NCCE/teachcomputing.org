require "rails_helper"

RSpec.describe "Admin Root Request Spec" do
  let(:jwt_payload) { {"email" => "admin@example.com"} }
  let(:jwt_token) { JWT.encode(jwt_payload, nil, "none") }

  before do
    allow(ENV).to receive(:fetch).and_call_original
    allow(ENV).to receive(:fetch).with("BYPASS_ADMINISTRATE_CF_AUTH", anything).and_return("false")
  end

  context "when BYPASS_ADMINISTRATE_CF_AUTH is true and not in production" do
    before do
      allow(ENV).to receive(:fetch).with("BYPASS_ADMINISTRATE_CF_AUTH", anything).and_return("true")
      allow(Rails.env).to receive(:production?).and_return(false)
    end

    it "allows access to admin root path" do
      get admin_root_path
      expect(response).to have_http_status(:ok)
    end
  end

  context "when authenticated with CF access" do
    let(:headers) { {"Cookie" => "CF_Authorization=#{jwt_token}"} }

    it "returns OK status for admin root path" do
      get admin_root_path, headers: headers
      expect(response).to have_http_status(:ok)
    end

    it "asks client not to cache potentially sensitive pages" do
      get admin_root_path, headers: headers
      expect(response.headers["Cache-Control"]).to eq("no-store")
    end

    it "decodes the cookie and sets @admin_email" do
      get admin_root_path, headers: headers
      controller = response.request.env["action_controller.instance"]
      expect(controller.instance_variable_get(:@admin_email)).to eq("admin@example.com")
    end
  end

  context "without CF access authentication" do
    it "redirects to the root of the application" do
      get admin_root_path
      expect(response).to redirect_to(root_path)
    end

    it "sets a flash error message" do
      get admin_root_path
      expect(flash[:error]).to eq("Whoops something went wrong")
    end
  end
end
