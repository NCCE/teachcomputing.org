require "rails_helper"

RSpec.describe Diagnostics::ClassMarker::CSAcceleratorController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }

  describe "GET show" do
    before do
      activity
    end

    describe "while logged in" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get class_marker_diagnostic_cs_accelerator_certificate_path(activity.id)
      end

      it "creates an Achievement if one does not exist already" do
        expect(user.achievements.where(activity_id: activity.id).exists?).to be true
      end

      it "redirects to the value of the CLASS_MARKER_DIAGNOSTIC_URL variable" do
        expect(response).to redirect_to(ENV.fetch("CLASS_MARKER_DIAGNOSTIC_URL") + "&cm_e=#{user.email}&cm_user_id=#{user.id}")
      end

      it "creates an achievement in a state of complete" do
        expect(user.achievements.where(activity_id: activity.id).first.current_state).to eq "complete"
      end
    end

    describe "while logged out" do
      before do
        get class_marker_diagnostic_cs_accelerator_certificate_path(activity.id)
      end

      it "redirects to login" do
        expect(response).to redirect_to(/signup/)
      end

      it "does not create an Achievement" do
        expect(Achievement.count).to eq 0
      end
    end
  end
end
