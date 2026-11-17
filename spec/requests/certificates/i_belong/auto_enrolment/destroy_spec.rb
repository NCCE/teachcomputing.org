require "rails_helper"

RSpec.describe Certificates::IBelong::AutoEnrolmentsController do
  let(:user) { create(:user) }
  let(:programme) { create(:i_belong) }

  describe "GET #destroy" do
    subject(:unenroll) { get unenroll__i_belong_auto_enrolment_path }

    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context "when user is enrolled on i_belong" do
      let!(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

      it "redirects to the dashboard path" do
        unenroll
        expect(response).to redirect_to(dashboard_path)
      end

      it "sets the users enrolment to :unenrolled" do
        user_enrolment = user.user_programme_enrolments.find_by(programme: programme)

        expect { unenroll }
          .to change { user_enrolment.reload.current_state }
          .from("enrolled")
          .to("unenrolled")
      end

      it "shows a flash notice" do
        unenroll
        expect(flash[:notice]).to be_present
      end

      it "flash notice has correct info" do
        unenroll
        expect(flash[:notice]).to match(/You have successfully opted out of I Belong/)
      end
    end

    context "when user has already unenrolled" do
      let!(:enrolment) do
        create(:user_programme_enrolment, user: user, programme: programme).tap do |enrolment|
          enrolment.transition_to(:unenrolled)
        end
      end

      it "leaves the enrolment unenrolled and redirects to the dashboard without a notice" do
        unenroll

        expect(enrolment.reload.current_state).to eq "unenrolled"
        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to be_nil
      end
    end

    context "when user's enrolment is pending" do
      let!(:enrolment) do
        create(:user_programme_enrolment, user: user, programme: programme).tap do |enrolment|
          enrolment.transition_to(:pending)
        end
      end

      it "leaves the enrolment pending and redirects to the dashboard without a notice" do
        unenroll

        expect(enrolment.reload.current_state).to eq "pending"
        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to be_nil
      end
    end

    context "when signed out" do
      let!(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      end

      it "redirects to login, returning to the unenrol link afterwards, without unenrolling" do
        unenroll

        expect(response).to redirect_to(login_path(source_uri: unenroll__i_belong_auto_enrolment_url))
        expect(enrolment.reload.current_state).to eq "enrolled"
      end
    end

    context "when user is not enrolled" do
      it "redirects to dashboard" do
        unenroll
        expect(response).to redirect_to(dashboard_path)
      end

      it "does not show flash message" do
        unenroll
        expect(flash[:notice]).not_to be_present
      end
    end
  end
end
