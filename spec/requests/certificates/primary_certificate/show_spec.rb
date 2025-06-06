require "rails_helper"

RSpec.describe Certificates::PrimaryCertificateController do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
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
    before do
      stub_strapi_programme("primary-certificate")
      stub_strapi_aside_section("primary-certificate-need-help")
      stub_strapi_aside_section("primary-dashboard-cpd-section")
    end
    context "when user is logged in" do
      before do
        allow_any_instance_of(ProgrammeActivityGrouping).to receive(:user_complete?).and_return(true)
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)

        stub_strapi_aside_section("primary-certificate-progress-bar-aside")
      end

      context "when user is not enrolled" do
        it "redirects if not enrolled" do
          programme

          get primary_certificate_path
          expect(response).to redirect_to("/primary-certificate")
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

    describe "while logged out" do
      it "redirects to login" do
        get primary_certificate_path
        expect(response).to redirect_to(/auth\/stem\?screen_hint=signup/)
      end
    end
  end
end
