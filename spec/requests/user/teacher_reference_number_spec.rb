require "rails_helper"

RSpec.describe UserController do
  let(:user) { create(:user) }

  describe "POST #teacher_reference_number" do
    before do
      user
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end
    context "with valid params" do
      subject do
        allow_any_instance_of(
          described_class
        ).to(
          receive(:trn_redirect_path).and_return(
            cs_accelerator_path
          )
        )
        patch user_teacher_reference_number_path(user),
          params: {
            user: {teacher_reference_number: "TRN123"},
            redirect_path: cs_accelerator_path
          }
      end

      before do
        subject
      end

      it "redirects to the chosen path" do
        expect(response).to redirect_to(cs_accelerator_path)
      end

      it "updates the teacher reference number" do
        user.reload
        expect(user.teacher_reference_number).to eq("TRN123")
      end

      it "shows a flash notice" do
        expect(flash[:notice]).to be_present
      end

      it "flash notice has correct info" do
        expect(flash[:notice]).to eq("Teacher reference number added")
      end
    end

    context "with invalid params" do
      subject do
        patch user_teacher_reference_number_path(user),
          params: {
            user: {teacher_reference_number: nil},
            redirect_path: nil
          }
      end

      before do
        subject
      end

      it "redirects to the default path" do
        expect(response).to redirect_to(dashboard_path)
      end

      it "does not update user" do
        expect(user.teacher_reference_number).to be(nil)
      end

      it "shows a flash error" do
        expect(flash[:error]).to be_present
      end

      it "flash error has correct info" do
        expect(flash[:error]).to match(/enter your teacher reference number/)
      end
    end
  end
end
