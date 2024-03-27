require "rails_helper"

RSpec.describe Api::UsersController do
  let(:user) { create(:user, email: ENV.fetch("DEFAULT_ADMIN_EMAIL")) }
  let(:activity) {
    create(
      :activity,
      programme_activities: [create(:programme_activity, programme:, activity:)]
    )
  }
  let(:programme) { create(:programme) }
  let(:enrolment) { create(:user_programme_enrolment, user:, programme:) }
  let(:uploadable_activity) { create(:activity, uploadable: true) }
  let(:achievement) do
    create(
      :achievement,
      :with_supporting_evidence,
      activity_id: uploadable_activity.id,
      user_id: user.id
    )
  end
  let(:token_headers) { {HTTP_AUTHORIZATION: "Bearer secret", HTTP_CONTENT_TYPE: "application/json"} }

  context "when token is not passed" do
    describe "GET #show" do
      before do
        get "/api/users/", params: {email: user.email}, headers: nil
      end

      it "returns 401 status" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context "when the correct token is passed" do
    describe "GET #show" do
      before do
        enrolment
        achievement
        get "/api/users/", params: {email: user.email}, headers: token_headers
      end

      it "returns 201 status" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the users information" do
        expect(JSON.parse(response.body)["id"]).to eq user.id
        expect(JSON.parse(response.body)["email"]).to eq user.email
        expect(JSON.parse(response.body)["stem_achiever_contact_no"]).to eq user.stem_achiever_contact_no
        expect(JSON.parse(response.body)["stem_user_id"]).to eq user.stem_user_id
      end

      it "contains the users achievements" do
        expect(JSON.parse(response.body)["achievements"].count).to eq 1
      end

      it "contains the users enrolments" do
        expect(JSON.parse(response.body)["enrolments"].count).to eq 1
      end
    end

    describe "DELETE #forget" do
      before do
        enrolment
        achievement
        delete "/api/users/forget", params: {stem_user_id: user.stem_user_id}, headers: token_headers
      end

      it "returns 200 status" do
        expect(response).to have_http_status(:ok)
      end

      it "updates the email address" do
        expect(JSON.parse(response.body)["email"]).to eq "#{user.id}@devnull-ncce.slcs.ac.uk"
      end

      it "removes the future_learn_organisation_memberships" do
        expect(JSON.parse(response.body)["future_learn_organisation_memberships"]).to be_nil
      end

      it "scrubs the credentials" do
        updated_user = User.find(user.id)
        expect(updated_user.stem_credentials_expires_at).to be_within(10.seconds).of(DateTime.now)
        expect(updated_user.encrypted_stem_credentials_refresh_token).not_to eq(user.encrypted_stem_credentials_refresh_token)
        expect(updated_user.encrypted_stem_credentials_access_token).not_to eq(user.encrypted_stem_credentials_access_token)
      end

      it "scrubs the exposed parameters" do
        params_to_skip = %w[email future_learn_organisation_memberships created_at updated_at enrolments achievements]
        parsed_response = JSON.parse(response.body)
        parsed_response.each do |key, value|
          next if params_to_skip.include? key

          expect(value).to eq(user.id)
        end
      end

      it "sets last_sign_in_at to nil" do
        expect(JSON.parse(response.body)["last_sign_in_at"]).to be_nil
      end

      it "does not break the relationships" do
        expect(JSON.parse(response.body)["achievements"].count).to eq 1
        expect(JSON.parse(response.body)["enrolments"].count).to eq 1
      end

      it "flags the user as forgotten" do
        updated_user = User.find(user.id)
        expect(updated_user.forgotten).to be true
      end

      it "removes any supporting evidence" do
        achievement.reload
        expect(achievement.supporting_evidence.attached?).to be false
      end
    end
  end
end
