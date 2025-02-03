require "rails_helper"

RSpec.describe Admin::UsersController do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, email: "admin@example.com") }
  let(:assessment) { create(:assessment) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("admin@example.com")
  end

  describe "GET #perform_sync" do
    before do
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

  context "GET #generate_assessment_attempt" do
    before do
      get admin_user_generate_assessment_attempt_path(user_id: user.id)
    end

    it "should render correct template" do
      expect(response).to render_template("generate_assessment_attempt")
    end
  end

  context "POST #process_assessment_attempt" do
    context "with passing score" do
      before do
        post admin_user_process_assessment_attempt_path(user_id: user.id), params: {
          assessment_id: assessment.id,
          score: 85
        }
      end

      it "should redirect to user" do
        expect(response).to redirect_to(admin_user_path(user))
      end

      it "should mark assessment_attempt complete" do
        attempt = user.assessment_attempts.where(assessment:).first
        expect(attempt.current_state).to eq("passed")
      end
    end

    context "with failing score" do
      before do
        post admin_user_process_assessment_attempt_path(user_id: user.id), params: {
          assessment_id: assessment.id,
          score: 25
        }
      end

      it "should redirect to user" do
        expect(response).to redirect_to(admin_user_path(user))
      end

      it "should mark assessment_attempt complete" do
        attempt = user.assessment_attempts.where(assessment:).first
        expect(attempt.current_state).to eq("failed")
      end
    end
  end

  context "in production" do
    before do
      allow(Rails).to receive(:env) { "production".inquiry }
      Rails.application.reload_routes!
      user
    end

    after do
      allow(Rails).to receive(:env).and_call_original
      Rails.application.reload_routes!
    end

    describe "GET #generate_assessment_attempt" do
      it "should not route" do
        expect {
          get "/admin/users/#{user.id}/generate_assessement_attempt"
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "POST #process_assessment_attempt" do
      it "should not route" do
        expect {
          post "/admin/users/#{user.id}/process_assessement_attempt", params: {
            assessment_id: assessment.id,
            score: 86
          }
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
