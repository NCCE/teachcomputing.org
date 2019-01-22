require 'rails_helper'

RSpec.describe AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cpd) }

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
        expect(Achievement.count).to eq 1
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
        expect(Achievement.count).to eq 0
      end
    end
  end
end
