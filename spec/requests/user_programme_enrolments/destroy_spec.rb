require "rails_helper"

RSpec.describe UserProgrammeEnrolmentsController do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }

  describe "GET #destroy" do
    before do
      user
      enrolment
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context "with valid params" do
      before do
        get unenrol_cs_accelerator_certificate_path(enrolment.id)
      end

      it "transitions the record to unenrolled" do
        expect(enrolment.current_state).to eq "unenrolled"
      end

      it "redirects to dashboard path" do
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "with invalid params" do
      it "raises a 404 exception" do
        expect do
          get unenrol_cs_accelerator_certificate_path("123")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
