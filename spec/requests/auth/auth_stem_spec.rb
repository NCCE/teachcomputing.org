require "rails_helper"

RSpec.describe AuthController do
  describe "auth#stem" do
    it "redirects get requests correctly" do
      expect(get("/auth/stem")).to redirect_to(login_path)
    end
  end
end
