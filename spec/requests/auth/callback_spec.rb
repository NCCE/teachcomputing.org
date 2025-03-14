require "rails_helper"

RSpec.describe AuthController do
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

  let(:auth0_invalid_hash) {
    OmniAuth::AuthHash.new(
      provider: "stem",
      uid: "auth0|user@example.com",
      credentials: {
        expires_at: 1_546_601_180,
        token: "14849048797785647933"
      },
      info: {
        achiever_contact_no: nil,
        first_name: "Jane",
        last_name: "Doe",
        email: "user@example.com",
        stem_user_id: nil

      }
    )
  }

  describe "#callback" do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:stem] = auth0_hash
    end

    it "sets the user session" do
      user
      get callback_path

      expect(session["user_id"]).to eq(user.id)
    end

    context "when source_uri is present" do
      before do
        allow_any_instance_of(
          described_class
        ).to(
          receive(:course_redirect_params).and_return(
            "http://www.example.com/test"
          )
        )
      end

      it "redirects to the path stated in source_uri" do
        get callback_path

        expect(response).to redirect_to("/test?firstLogin=true")
      end
    end

    context "invalid info" do
      before do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:stem] = auth0_invalid_hash
      end

      it "raises exception when data missing" do
        expect {
          get callback_path
        }.to raise_error(StandardError)
      end
    end

    context "when source_uri is not present" do
      before do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:stem] = auth0_hash
      end

      it "redirects to the dashboard path" do
        get callback_path
        expect(response).to redirect_to("/dashboard?firstLogin=true")
      end
    end
  end
end
