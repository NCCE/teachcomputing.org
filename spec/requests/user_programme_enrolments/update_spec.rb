require "rails_helper"

RSpec.describe UserProgrammeEnrolmentsController do
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user:) }

  describe "PUT #update" do
    before do
      user
      user_programme_enrolment
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context "with valid params" do
      before do
        put user_programme_enrolment_path(user_programme_enrolment), params: {user_programme_enrolment: {certificate_name: "bob"}}
      end

      it "redirects to the dashboard_path" do
        expect(response).to redirect_to(dashboard_path)
      end

      it "shows a flash notice" do
        expect(flash[:notice]).to be_present
      end

      it "flash notice has correct info" do
        expect(flash[:notice]).to eq "Successfully updated user details."
      end
    end

    context "if the update failed" do
      before do
        allow_any_instance_of(UserProgrammeEnrolment).to receive(:update).and_return(false)
        put user_programme_enrolment_path(user_programme_enrolment), params: {user_programme_enrolment: {certificate_name: "bob"}}
      end

      it "redirects to the dashboard_path" do
        expect(response).to redirect_to(dashboard_path)
      end

      it "shows a flash notice" do
        expect(flash[:error]).to be_present
      end

      it "flash notice has correct info" do
        expect(flash[:error]).to eq "Failed to update user details."
      end
    end
  end
end
