require "rails_helper"

RSpec.describe "Admin::AchievementsController" do
  let(:user) { create(:user) }
  let(:programme) { create(:programme) }
  let(:other_programme) { create(:programme) }
  let(:activity) { create(:activity, programmes: [programme, other_programme]) }
  let(:other_activity) { create(:activity, programmes: [other_programme]) }
  let(:user_programme_enrolment) { create(:pending_enrolment, programme:, user:) }
  let(:other_enrolment) { create(:completed_enrolment, programme: other_programme, user:) }
  let(:other_achievement) { create(:achievement, user:, activity: other_activity) }
  let(:achievement) { create(:completed_achievement, user:, activity:) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  describe "GET #index" do
    before do
      get admin_achievements_path
    end

    it "renders the correct template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_achievement_path(achievement)
    end

    it "renders the correct template" do
      expect(response).to render_template("show")
    end
  end

  describe "POST #reject_evidence" do
    before do
      user_programme_enrolment
      other_enrolment
    end

    context "completed achievement" do
      before do
        post reject_evidence_admin_achievement_path(achievement)
      end

      it "redirects to user show page" do
        expect(response).to redirect_to(admin_user_path(user))
      end

      it "sets achievement to rejected" do
        expect(achievement.current_state).to eq("rejected")
      end

      it "should roll back pending enrolments but not completed" do
        expect(user_programme_enrolment.current_state).to eq("enrolled")
        expect(other_enrolment.current_state).to eq("complete")
      end
    end

    context "not completed achievement" do
      before do
        post reject_evidence_admin_achievement_path(other_achievement)
      end

      it "redirects to user show page" do
        expect(response).to redirect_to(admin_user_path(user))
        expect(flash[:alert]).to eq("Unable to reject the evidence")
      end

      it "unable to rejected not completed evidence" do
        expect(other_achievement.current_state).not_to eq("rejected")
      end
    end
  end
end
