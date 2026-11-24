require "rails_helper"

RSpec.describe Certificates::IBelong::AutoEnrolmentsController do
  let(:user) { create(:user) }
  let!(:programme) { create(:i_belong) }
  let(:path) { unenroll__i_belong_auto_enrolment_path }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
  end

  describe "GET #confirm_destroy" do
    subject(:confirm) { get path }

    context "when user is enrolled" do
      let!(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

      it "shows the confirmation page without unenrolling" do
        confirm

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("You're about to leave <strong>I Belong</strong>")
        expect(response.body).to include(%(href="#{programme.path}"))
        expect(response.body).to include(%(action="#{path}"))
        expect(enrolment.reload.current_state).to eq "enrolled"
      end
    end

    context "when user has already unenrolled" do
      before do
        create(:user_programme_enrolment, user: user, programme: programme).transition_to(:unenrolled)
      end

      it "redirects to the dashboard with a notice" do
        confirm

        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq "You are not enrolled on I Belong"
      end
    end

    context "when user's enrolment is pending" do
      let!(:enrolment) do
        create(:user_programme_enrolment, user: user, programme: programme).tap do |enrolment|
          enrolment.transition_to(:pending)
        end
      end

      it "redirects to the dashboard with a notice, leaving the enrolment pending" do
        confirm

        expect(enrolment.reload.current_state).to eq "pending"
        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq "Your enrolment on I Belong can't be withdrawn at this stage"
      end
    end

    context "when user is not enrolled" do
      it "redirects to the dashboard with a notice" do
        confirm

        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq "You are not enrolled on I Belong"
      end
    end

    context "when signed out" do
      let!(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      end

      it "redirects to login, returning to the confirmation page afterwards, without unenrolling" do
        confirm

        expect(response).to redirect_to(login_path(source_uri: unenroll__i_belong_auto_enrolment_url))
        expect(enrolment.reload.current_state).to eq "enrolled"
      end
    end
  end

  describe "POST #destroy" do
    subject(:unenroll) { post path }

    context "when user is enrolled" do
      let!(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

      it "unenrols the user and redirects to the dashboard with a notice" do
        expect { unenroll }
          .to change { enrolment.reload.current_state }
          .from("enrolled")
          .to("unenrolled")

        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq "You have successfully opted out of I Belong"
      end

      context "with forgery protection on" do
        around do |example|
          ActionController::Base.allow_forgery_protection = true
          example.run
        ensure
          ActionController::Base.allow_forgery_protection = false
        end

        it "rejects a request without an authenticity token" do
          expect { unenroll }.to raise_error(ActionController::InvalidAuthenticityToken)
          expect(enrolment.reload.current_state).to eq "enrolled"
        end
      end
    end

    context "when user's enrolment is pending" do
      let!(:enrolment) do
        create(:user_programme_enrolment, user: user, programme: programme).tap do |enrolment|
          enrolment.transition_to(:pending)
        end
      end

      it "leaves the enrolment pending and redirects to the dashboard" do
        unenroll

        expect(enrolment.reload.current_state).to eq "pending"
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when user is not enrolled" do
      it "redirects to the dashboard" do
        unenroll
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when signed out" do
      let!(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      end

      it "redirects to login without unenrolling" do
        unenroll

        expect(response).to redirect_to(login_path(source_uri: unenroll__i_belong_auto_enrolment_url))
        expect(enrolment.reload.current_state).to eq "enrolled"
      end
    end
  end
end
