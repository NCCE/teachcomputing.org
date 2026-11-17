require "rails_helper"

RSpec.describe UserProgrammeEnrolmentsController do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let!(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }
  let!(:other_enrolment) { create(:user_programme_enrolment, user: other_user, programme: programme) }

  describe "GET #destroy" do
    context "when signed in" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      it "unenrols the user and redirects to the dashboard" do
        get unenrol_cs_accelerator_certificate_path(enrolment.id)

        expect(enrolment.reload.current_state).to eq "unenrolled"
        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq "You have successfully opted out of the #{programme.title}"
      end

      it "does nothing if the user is already unenrolled" do
        enrolment.transition_to(:unenrolled)

        get unenrol_cs_accelerator_certificate_path(enrolment.id)

        expect(enrolment.reload.current_state).to eq "unenrolled"
        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to be_nil
      end

      it "raises not found for another user's enrolment and leaves it alone" do
        expect do
          get unenrol_cs_accelerator_certificate_path(other_enrolment.id)
        end.to raise_error(ActiveRecord::RecordNotFound)

        expect(other_enrolment.reload.current_state).to eq "enrolled"
      end

      it "raises not found for an unknown enrolment" do
        expect do
          get unenrol_cs_accelerator_certificate_path("123")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when signed out" do
      it "redirects to login, returning to the unenrol link afterwards, without unenrolling" do
        get unenrol_cs_accelerator_certificate_path(enrolment.id)

        expect(response).to redirect_to(
          login_path(source_uri: unenrol_cs_accelerator_certificate_url(enrolment.id))
        )
        expect(enrolment.reload.current_state).to eq "enrolled"
      end
    end
  end
end
