require 'rails_helper'

RSpec.describe AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :stem_learning) }

  describe 'POST #create' do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context 'with valid params' do
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

      it 'creates the Achievement' do
        expect(user.achievements.where(activity_id: activity.id).exists?).to eq true
      end

      it 'creates an achievement with the correct complete state' do
        expect(user.achievements.where(activity_id: activity.id).first.current_state).to eq 'complete'
      end

      it 'shows a flash notice' do
        expect(flash[:notice]).to be_present
      end

      it 'flash notice has correct info' do
        expect(flash[:notice]).to match(/'#{activity.title}' has been added/)
      end
    end

    context 'with invalid params' do
      subject do
        post achievements_path,
             params: {
               achievement: { activity_id: nil }
             }
      end

      before do
        subject
      end

      it 'redirects to the dashboard path' do
        expect(response).to redirect_to(dashboard_path)
      end

      it 'does not create an Achievement' do
        expect(user.achievements.where(activity_id: activity.id).exists?).to eq false
      end

      it 'shows a flash error' do
        expect(flash[:error]).to be_present
      end

      it 'flash error has correct info' do
        expect(flash[:error]).to match(/something went wrong adding/)
      end
    end
  end
end
