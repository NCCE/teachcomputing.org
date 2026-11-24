require "rails_helper"

RSpec.describe UserProgrammeEnrolmentsController do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let!(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }
  let!(:other_enrolment) { create(:user_programme_enrolment, user: other_user, programme: programme) }

  describe "GET #confirm_destroy" do
    context "when signed in" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      it "shows the confirmation page without unenrolling" do
        get unenrol_cs_accelerator_certificate_path(enrolment.id)

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("You're about to leave <strong>#{ERB::Util.html_escape("the #{programme.title}")}</strong>")
        expect(response.body).to include(%(href="#{programme.path}"))
        expect(response.body).to include(%(action="#{unenrol_cs_accelerator_certificate_path(enrolment.id)}"))
        expect(enrolment.reload.current_state).to eq "enrolled"
      end

      it "redirects to the dashboard with a notice if the user is already unenrolled" do
        enrolment.transition_to(:unenrolled)

        get unenrol_cs_accelerator_certificate_path(enrolment.id)

        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq "You are not enrolled on the #{programme.title}"
      end

      it "redirects to the dashboard with a notice if the enrolment can't be withdrawn" do
        enrolment.transition_to(:pending)

        get unenrol_cs_accelerator_certificate_path(enrolment.id)

        expect(enrolment.reload.current_state).to eq "pending"
        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq "Your enrolment on the #{programme.title} can't be withdrawn at this stage"
      end

      it "raises not found for another user's enrolment" do
        expect do
          get unenrol_cs_accelerator_certificate_path(other_enrolment.id)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when signed out" do
      it "redirects to login, returning to the confirmation page afterwards, without unenrolling" do
        get unenrol_cs_accelerator_certificate_path(enrolment.id)

        expect(response).to redirect_to(
          login_path(source_uri: unenrol_cs_accelerator_certificate_url(enrolment.id))
        )
        expect(enrolment.reload.current_state).to eq "enrolled"
      end
    end
  end

  describe "POST #destroy" do
    context "when signed in" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      it "unenrols the user and redirects to the dashboard" do
        post unenrol_cs_accelerator_certificate_path(enrolment.id)

        expect(enrolment.reload.current_state).to eq "unenrolled"
        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq "You have successfully opted out of the #{programme.title}"
      end

      it "does not unenrol if the enrolment can't be withdrawn" do
        enrolment.transition_to(:pending)

        post unenrol_cs_accelerator_certificate_path(enrolment.id)

        expect(enrolment.reload.current_state).to eq "pending"
        expect(response).to redirect_to(dashboard_path)
      end

      it "raises not found for another user's enrolment and leaves it alone" do
        expect do
          post unenrol_cs_accelerator_certificate_path(other_enrolment.id)
        end.to raise_error(ActiveRecord::RecordNotFound)

        expect(other_enrolment.reload.current_state).to eq "enrolled"
      end

      it "raises not found for an unknown enrolment" do
        expect do
          post unenrol_cs_accelerator_certificate_path("123")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      context "with forgery protection on" do
        around do |example|
          ActionController::Base.allow_forgery_protection = true
          example.run
        ensure
          ActionController::Base.allow_forgery_protection = false
        end

        it "rejects a request without an authenticity token" do
          expect do
            post unenrol_cs_accelerator_certificate_path(enrolment.id)
          end.to raise_error(ActionController::InvalidAuthenticityToken)

          expect(enrolment.reload.current_state).to eq "enrolled"
        end
      end
    end

    context "when signed out" do
      it "redirects to login without unenrolling" do
        post unenrol_cs_accelerator_certificate_path(enrolment.id)

        expect(response).to redirect_to(
          login_path(source_uri: unenrol_cs_accelerator_certificate_url(enrolment.id))
        )
        expect(enrolment.reload.current_state).to eq "enrolled"
      end
    end
  end
end
