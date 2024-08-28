require "rails_helper"

RSpec.describe Certificates::PrimaryCertificateController do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:badge) { create(:badge, programme:) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id)
  end
  let(:online_discussion_grouping) do
    create(:programme_activity_grouping, sort_key: 3, title: "online discussion activities", programme: programme)
  end
  let(:online_discussion_programme_activity) do
    create(:programme_activity, programme: programme, programme_activity_grouping: online_discussion_grouping)
  end

  describe "#show" do
    context "when user is logged in" do
      before do
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      context "when user is not enrolled" do
        it "redirects if not enrolled" do
          programme

          get primary_certificate_path
          expect(response).to redirect_to(primary_path)
        end
      end

      context "when user is enrolled" do
        it "asks client not to cache a private page" do
          user_programme_enrolment
          online_discussion_programme_activity

          get primary_certificate_path
          expect(response.headers["cache-control"]).to eq("no-store")
        end
      end
    end

    describe "enrolled with badge" do
      before do
        badge
        user_programme_enrolment
        stub_issued_badges(user.id)
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
        get primary_certificate_path
      end

      it "renders the correct template" do
        expect(response).to render_template("show")
      end
    end

    describe "enrolled with badge but credly errors" do
      before do
        badge
        user_programme_enrolment
        stub_issued_badges_failure(user.id)
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
        get primary_certificate_path
      end

      it "renders the correct template" do
        expect(response).to render_template("show")
      end
    end

    describe "while logged out" do
      it "redirects to login" do
        get primary_certificate_path
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
