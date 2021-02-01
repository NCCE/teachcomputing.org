require 'rails_helper'

RSpec.describe AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :stem_learning) }
  let(:achievement) { create(:achievement, activity_id: activity.id, user_id: user.id) }

  describe 'DELETE #destroy' do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context 'with valid params' do
      subject do
        delete achievement_path(id: achievement.id)
      end

      before do
        subject
      end

      it 'redirects to the dashboard path' do
        expect(response).to redirect_to(dashboard_path)
      end

      it 'removes the Achievement' do
        expect(user.achievements.where(activity_id: activity.id).exists?).to eq false
      end

      it 'shows a flash notice' do
        expect(flash[:notice]).to match(/'#{activity.title}' has been removed/)
      end
    end

    context 'with invalid params' do
      subject do
        delete achievement_path(id: 'invalid')
      end

      before do
        create(:achievement)
      end

      it 'redirects to the dashboard path' do
        subject
        expect(response).to redirect_to(dashboard_path)
      end

      it 'does not delete an Achievement' do
        expect { subject }.not_to change { Achievement.all.count }
      end

      it 'shows a flash error' do
        subject
        expect(flash[:error]).to match(/something went wrong removing/)
      end
    end
  end
end
