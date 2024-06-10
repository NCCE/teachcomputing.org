require "rails_helper"

RSpec.describe Admin::UsersController do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, email: "admin@example.com") }

  describe "GET #perform_sync" do
    before do
      allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("admin@example.com")
      allow(Support::UserUtilities).to receive(:sync).and_return("success")
    end

    it "calls the sync service and redirects back with a notice" do
      get admin_user_perform_sync_path(user_id: user.id)

      expect(response).to redirect_to(admin_users_path(user_id: user.id))
      expect(flash[:notice]).to eq("Sync complete")
    end
  end

  describe "GET #perform_reset_tests" do
    before do
      allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("admin@example.com")
      allow(User).to receive(:find_by_email).and_return(admin_user)
      allow(Support::UserUtilities).to receive(:reset_tests).and_return([])
    end

    context "when reset tests result is empty" do
      it "calls the reset service and redirects back with a notice" do
        get admin_user_perform_reset_path(user_id: user.id)

        expect(response).to redirect_to(admin_users_path(user.id))
        expect(flash[:notice]).to eq("Nothing to do!")
      end
    end

    context "when reset tests result is not empty" do
      let(:support_audit) { create(:support_audit, user: admin_user) }

      before do
        allow(Support::UserUtilities).to receive(:reset_tests).and_return(["result"])
        allow(SupportAudit).to receive(:where).with(user_id: admin_user.id).and_return([support_audit])
      end

      it "calls the reset service and redirects to edit the last support audit" do
        get admin_user_perform_reset_path(user_id: user.id)

        expect(response).to redirect_to(edit_admin_support_audit_path(id: support_audit.id))
      end
    end
  end
end
