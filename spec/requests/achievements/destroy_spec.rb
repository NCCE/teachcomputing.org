require 'rails_helper'

RSpec.describe AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :stem_learning) }
  let(:achievement) { create(:achievement, activity_id: activity.id, user_id: user.id) }

  describe 'DELETE #destroy' do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      delete achievement_path(id: achievement.id)
    end

    it 'redirects to the dashboard path' do
      expect(response).to redirect_to(dashboard_path)
    end

    it 'removes the Achievement' do
      expect(user.achievements.where(activity_id: activity.id).exists?).to eq false
    end
  end
end
