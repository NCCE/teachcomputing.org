require 'rails_helper'

RSpec.describe AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cpd) }
  let(:achievement) { create(:achievement, :activity, :user) }

  describe 'DELETE #destroy' do
    before do
      puts "Acheivement: #{Achievement.count}"
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    subject do
      post achievements_path,
           params: {
             achievement: { activity_id: activity.id }
           }
    end

    before do
      subject
    end

    it 'redirects to the dashboard path' do
      expect(response).to redirect_to(dashboard_path)
    end

    it 'removes the Achievement' do
      expect(Achievement.count).to eq 0
    end

  end
end
