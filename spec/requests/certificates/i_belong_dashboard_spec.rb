require "rails_helper"

RSpec.describe Certificates::IBelongController do
  let(:user) { create(:user) }
  let(:certificate) { create(:i_belong) }
  let(:badge) { create(:badge, programme: certificate) }
  let(:enrolment) { create(:user_programme_enrolment, user: user, programme: certificate) }
  let!(:programme_activity_grouping) { create(:programme_activity_grouping, programme: certificate) }

  describe "#show" do
    before do
      stub_attendance_sets
      stub_delegate
      stub_strapi_aside_section("i-belong-dashboard-help-section")
      stub_strapi_aside_section("i-belong-community-help")
    end

    describe "while unenrolled" do
      before do
        certificate
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/i-belong"
      end

      it "redirects to I Belong public page" do
        expect(response).to redirect_to(about_i_belong_path)
      end
    end

    describe "while enrolled" do
      before do
        enrolment
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/i-belong"
      end

      it "renders the correct template" do
        expect(response).to render_template("show")
      end

      it "asks client not to cache a private page" do
        expect(response.headers["cache-control"]).to eq("no-store")
      end
    end

    describe "enrolled with badge" do
      before do
        badge
        enrolment
        stub_issued_badges(user.id)
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/i-belong"
      end

      it "renders the correct template" do
        expect(response).to render_template("show")
      end
    end

    describe "enrolled with badge but credly errors" do
      before do
        badge
        enrolment
        stub_issued_badges_failure(user.id)
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/i-belong"
      end

      it "renders the correct template" do
        expect(response).to render_template("show")
      end
    end

    describe "while logged out" do
      before do
        get "/certificate/i-belong"
      end

      it "redirects to login" do
        expect(response).to redirect_to(Rails.application.config.stem_account_site)
      end
    end
  end

  describe "#pending" do
    before do
      stub_attendance_sets
      stub_delegate
    end

    describe "while unenrolled" do
      before do
        certificate
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/i-belong/pending"
      end

      it "redirects to I Belong public page" do
        expect(response).to redirect_to(about_i_belong_path)
      end
    end

    describe "while enrolled" do
      before do
        enrolment
        enrolment.transition_to :pending
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/i-belong/pending"
      end

      it "renders the correct template" do
        expect(response).to render_template("pending")
      end

      it "asks client not to cache a private page" do
        expect(response.headers["cache-control"]).to eq("no-store")
      end
    end

    describe "while logged out" do
      before do
        get "/certificate/i-belong/pending"
      end

      it "redirects to login" do
        expect(response).to redirect_to(Rails.application.config.stem_account_site)
      end
    end
  end

  describe "#complete" do
    before do
      stub_attendance_sets
      stub_delegate
    end

    describe "while unenrolled" do
      before do
        certificate
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/i-belong/complete"
      end

      it "redirects to I Belong public page" do
        expect(response).to redirect_to(about_i_belong_path)
      end
    end

    describe "while enrolled" do
      before do
        enrolment
        allow_any_instance_of(Programmes::IBelong).to receive(:user_completed?).and_return(true)
        enrolment.transition_to :complete
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/i-belong/complete"
      end

      it "renders the correct template" do
        expect(response).to render_template("complete")
      end

      it "asks client not to cache a private page" do
        expect(response.headers["cache-control"]).to eq("no-store")
      end
    end

    describe "while logged out" do
      before do
        get "/certificate/i-belong/complete"
      end

      it "redirects to login" do
        expect(response).to redirect_to(Rails.application.config.stem_account_site)
      end
    end
  end
end
