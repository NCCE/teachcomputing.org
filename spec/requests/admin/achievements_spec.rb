require "rails_helper"

RSpec.describe "Admin::AchievementsController" do
  let(:user) { create(:user) }
  let(:programme) { create(:programme) }
  let!(:cs_accelerator) { create(:cs_accelerator) }
  let(:other_programme) { create(:programme) }
  let(:activity) { create(:activity, programmes: [programme, other_programme]) }
  let(:other_activity) { create(:activity, programmes: [other_programme]) }
  let(:user_programme_enrolment) { create(:pending_enrolment, programme:, user:) }
  let(:other_enrolment) { create(:completed_enrolment, programme: other_programme, user:) }
  let(:other_achievement) { create(:achievement, user:, activity: other_activity) }
  let(:achievement) { create(:completed_achievement, user:, activity:) }

  before do
    # Issue with in-build argument checker in rpsec - https://github.com/rspec/rspec/issues/104
    # Disabled argument checker in this test
    RSpec::Mocks.configuration.verify_partial_doubles = false
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  after do
    RSpec::Mocks.configuration.verify_partial_doubles = true
  end

  describe "GET #index" do
    before do
      get admin_achievements_path
    end

    it "renders the correct template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    before do
      get new_admin_achievement_path
    end

    it "renders the correct template" do
      expect(response).to render_template("new")
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

  describe "POST #create" do
    it "should create achievement" do
      expect {
        post admin_achievements_url(params: {
          achievement: {
            user_id: user.id,
            activity_id: activity.id
          }
        })
      }.to change(Achievement, :count).by(1)
    end

    it "should call jobs when set to complete" do
      post admin_achievements_url(params: {
        achievement: {
          user_id: user.id,
          activity_id: activity.id,
          current_state: :complete
        }
      })
      expect(AssessmentEligibilityJob).to have_been_enqueued.with(user.id)
      expect(CertificatePendingTransitionJob).to have_been_enqueued.with(user, {source: "Admin::AchievementsController"})
    end
  end

  describe "PATCH #update" do
    it "should call jobs when updated to complete" do
      patch admin_achievement_url(other_achievement, params: {
        achievement: {
          current_state: :complete
        }
      })
      expect(AssessmentEligibilityJob).to have_been_enqueued.with(user.id)
      expect(CertificatePendingTransitionJob).to have_been_enqueued.with(user, {source: "Admin::AchievementsController"})
    end
  end

  describe "DELETE #achievement" do
    before do
      achievement
    end

    it "should delete achievement" do
      expect {
        delete admin_achievement_url(achievement)
      }.to change(Achievement, :count).by(-1)
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

  context "in production" do
    before do
      allow(Rails).to receive(:env) { "production".inquiry }
      Rails.application.reload_routes!
      achievement
    end

    after do
      allow(Rails).to receive(:env).and_call_original
      Rails.application.reload_routes!
    end

    describe "GET #new" do
      it "should not route" do
        stub_strapi_web_page_not_found("admin_achievement_new") # Temp fix
        expect {
          get "/admin/achievement/new"
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "POST #create" do
      it "should not route" do
        expect {
          post admin_achievements_url(params: {
            achievement: {
              user_id: user.id,
              activity_id: activity.id
            }
          })
        }.to raise_error(ActionController::RoutingError)
      end
    end

    describe "PATCH #update" do
      it "should not route" do
        expect {
          patch admin_achievement_url(achievement, params: {
            achievement: {
              current_state: :complete
            }
          })
        }.to raise_error(ActionController::RoutingError)
      end
    end

    describe "DELETE #achievement" do
      it "should not route" do
        expect {
          delete admin_achievement_url(achievement)
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
