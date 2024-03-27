require "rails_helper"

RSpec.describe DashboardController do
  let(:user) { create(:user) }
  let!(:completed_achievement_1) { create(:completed_achievement, user: user, updated_at: "2020-12-15 11:28:34") }
  let!(:completed_achievement_2) { create(:completed_achievement, user: user, updated_at: "2020-12-15 09:28:34") }
  let!(:completed_achievement_3) { create(:completed_achievement, user: user, updated_at: "2020-12-15 12:28:34") }
  let!(:incomplete_achievement_1) { create(:achievement, user: user, created_at: "2020-12-15 12:28:34") }
  let!(:incomplete_achievement_2) { create(:achievement, user: user, created_at: "2020-12-15 13:28:34") }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let!(:diagnostic_achievement) { create(:achievement, user: user, activity: activity) }

  describe "#show" do
    before do
      stub_attendance_sets
      stub_delegate
    end

    describe "while logged in" do
      before do
        create(:primary_certificate)
        create(:secondary_certificate)
        create(:cs_accelerator)
        create(:i_belong)
        create(:a_level)
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get dashboard_path
      end

      it "assigns the users incomplete achievements" do
        expect(assigns(:incomplete_achievements).count).to eq 2
      end

      it "sorts incomplete achievements by created_at desc" do
        expect(assigns(:incomplete_achievements)).to eq([incomplete_achievement_2, incomplete_achievement_1])
      end

      it "assigns the users completed achievements" do
        expect(assigns(:completed_achievements).count).to eq 3
      end

      it "sorts completed achievements by updated_at desc" do
        expect(assigns(:completed_achievements)).to eq([completed_achievement_3, completed_achievement_1, completed_achievement_2])
      end

      it "does not include diagnostic achievement in assigned achievements" do
        expect(assigns(:completed_achievements)).not_to include diagnostic_achievement
        expect(assigns(:incomplete_achievements)).not_to include diagnostic_achievement
      end

      it "renders the correct template" do
        expect(response).to render_template("show")
      end

      it "asks client not to cache a private page" do
        expect(response.headers["cache-control"]).to eq("no-store")
      end
    end

    describe "while logged out" do
      before do
        get dashboard_path
      end

      it "redirects to login" do
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
