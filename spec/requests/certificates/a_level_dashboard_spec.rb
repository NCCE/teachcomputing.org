require "rails_helper"

RSpec.describe Certificates::ALevelController do
  let(:user) { create(:user) }
  let(:certificate) { create(:a_level) }
  let(:enrolment) { create(:user_programme_enrolment, user: user, programme: certificate) }
  let(:assessment) { create(:assessment, programme: certificate) }

  describe "#show" do
    before do
      stub_attendance_sets
      stub_delegate
    end

    describe "while unenrolled" do
      before do
        assessment
        certificate
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/a-level-certificate"
      end

      it "redirects to A Level public page" do
        expect(response).to redirect_to(about_a_level_path)
      end
    end

    describe "while enrolled" do
      before do
        assessment
        enrolment
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/a-level-certificate"
      end

      it "renders the correct template" do
        expect(response).to render_template("show")
      end

      it "asks client not to cache a private page" do
        expect(response.headers["cache-control"]).to eq("no-store")
      end
    end

    describe "while logged out" do
      before do
        get "/certificate/a-level-certificate"
      end

      it "redirects to login" do
        expect(response).to redirect_to(/auth\/stem\?screen_hint=signup/)
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
        assessment
        certificate
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/a-level-certificate/complete"
      end

      it "redirects to A Level public page" do
        expect(response).to redirect_to(about_a_level_path)
      end
    end

    describe "while enrolled" do
      before do
        assessment
        enrolment
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/a-level-certificate/complete"
      end

      it "renders the correct template" do
        expect(response).to redirect_to(a_level_path)
      end

      it "asks client not to cache a private page" do
        expect(response.headers["cache-control"]).to eq("no-store")
      end
    end

    describe "while completed" do
      before do
        assessment
        enrolment
        allow_any_instance_of(Programmes::ALevel).to receive(:user_meets_completion_requirement?).and_return(true)
        enrolment.transition_to(:complete)
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get "/certificate/a-level-certificate/complete"
      end

      it "renders the correct template" do
        expect(response).to render_template(:complete)
      end

      it "asks client not to cache a private page" do
        expect(response.headers["cache-control"]).to eq("no-store")
      end
    end

    describe "while logged out" do
      before do
        get "/certificate/a-level-certificate/complete"
      end

      it "redirects to login" do
        expect(response).to redirect_to(/auth\/stem\?screen_hint=signup/)
      end
    end
  end
end
