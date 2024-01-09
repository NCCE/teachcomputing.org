require "rails_helper"

RSpec.describe Certificates::IBelongController do
  let(:user) { create(:user) }
  let(:certificate) { create(:i_belong) }
  let(:enrolment) { create(:user_programme_enrolment, user: user, programme: certificate) }

  describe "#show" do
    before do
      stub_attendance_sets
      stub_delegate
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

    describe "while logged out" do
      before do
        get "/certificate/i-belong"
      end

      it "redirects to login" do
        expect(response).to redirect_to(/register/)
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
        expect(response).to redirect_to(/register/)
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
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
