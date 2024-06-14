require "rails_helper"

RSpec.describe PagesController do
  include ApplicationHelper

  let(:user) { create(:user) }
  let(:programme) { create(:i_belong) }
  let!(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

  before do
    allow(Programme).to receive(:i_belong).and_return(programme)
  end

  describe "GET #i_belong" do
    context "when user is enrolled" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        allow(programme).to receive(:user_enrolled?).with(user).and_return(true)
        get about_i_belong_path
      end

      it "renders the enrolled template with correct locals" do
        expect(response).to render_template("pages/enrolment/i_belong")
        expect(response.body).to include("https://forms.office.com/e/x1FMMzjxhg")
        expect(response.body).to include("Request your posters")
        expect(response.body).to include("Download your handbook")
      end
    end

    context "when user is unenrolled" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        allow(programme).to receive(:user_enrolled?).with(user).and_return(false)
        allow(programme).to receive(:enrol_path).and_return("/enrol_path")
        get about_i_belong_path
      end

      it "renders the unenrolled template with correct locals" do
        expect(response).to render_template("pages/enrolment/i_belong")
        expect(response.body).to include("/enrol_path")
        expect(response.body).to include("Enrol to request")
        expect(response.body).to include("Enrol to download")
      end
    end

    context "when user is a guest" do
      before do
        get about_i_belong_path
      end

      it "renders the guest template with correct locals" do
        expect(response).to render_template("pages/enrolment/i_belong")
        expect(response.body).to include(auth_url)
        expect(response.body).to include("Log in to request")
        expect(response.body).to include("Log in to download")
      end
    end
  end
end
