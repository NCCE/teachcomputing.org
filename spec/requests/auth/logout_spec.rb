require "rails_helper"

RSpec.describe AuthController do
  describe "#logout" do
    let(:integration_key) { "13251241" }
    let(:user) { create(:user, stem_user_id: integration_key) }
    let(:auth0_hash) {
      OmniAuth::AuthHash.new(
        provider: "stem",
        uid: "auth0|user@example.com",
        credentials: {
          expires_at: 1_546_601_180,
          token: "14849048797785647933"
        },
        info: {
          achiever_contact_no: "b44cb53f-c690-4535-bd79-89e893337ec6",
          first_name: "Jane",
          last_name: "Doe",
          email: "user@example.com",
          stem_user_id: integration_key
        }
      )
    }

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:stem] = auth0_hash
      get callback_path
    end

    it "sets current user to nil" do
      expect(session[:user_id]).not_to be_nil
      get logout_path
      expect(session[:user_id]).to be_nil
    end

    it "redirects you to the root path" do
      get logout_path
      expect(response).to redirect_to("#{Rails.application.config.stem_account_domain}/user/logout")
    end
  end
end
