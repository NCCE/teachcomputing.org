require 'rails_helper'

RSpec.describe AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, self_verification_info: 'do something good') }

  before do
    allow_any_instance_of(AuthenticationHelper)
      .to receive(:current_user).and_return(user)
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:self_verification_info) { 'hello world' }

      before do
        post achievements_path, params: {
          achievement: {
            activity_id: activity.id,
            self_verification_info:
          }
        }
      end

      it 'returns a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'sets the success flash' do
        expect(flash[:notice].present?).to be true
      end

      it 'creates an achievement for the activity' do
        expect(user.achievements.first.activity).to eq activity
      end

      it 'creates an achievement with status drafted' do
        expect(user.achievements.first.drafted?).to be true
      end
    end

    context 'with invalid params' do
      let(:self_verification_info) { 'hello world' }

      before do
        post achievements_path, params: {
          achievement: {
            activity_id: nil,
            self_verification_info:
          }
        }
      end

      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'sets the error flash' do
        expect(flash[:error].present?).to be true
      end
    end
  end

  describe 'PUT #update' do
    let(:achievement) { create(:drafted_achievement, self_verification_info: 'hello world', user:, activity:) }
    context 'with valid params' do
      let(:self_verification_info) { 'hello world 2' }

      before do
        put achievement_path(achievement), params: {
          achievement: {
            self_verification_info:
          }
        }
      end

      it 'returns a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'sets the success flash' do
        expect(flash[:notice].present?).to be true
      end

      it 'updates achievement self_verification_info to new value' do
        expect(user.achievements.first.self_verification_info).to eq self_verification_info
      end
    end

    context 'with invalid params' do
      let(:self_verification_info) { 'hello world' }

      before do
        put achievement_path(achievement), params: {
          achievement: {
            self_verification_info:,
            activity_id: nil
          }
        }
      end

      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'sets the error flash' do
        expect(flash[:error].present?).to be true
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:achievement) { create(:drafted_achievement, self_verification_info: 'hello world', user:, activity:) }
    context 'with valid params' do
      before do
        delete achievement_path(achievement)
      end

      it 'returns a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'sets the success flash' do
        expect(flash[:notice].present?).to be true
      end

      it 'deletes the achievement' do
        expect(user.achievements.empty?).to be true
      end
    end

    context 'with invalid params' do
      before do
        allow_any_instance_of(Achievement)
          .to receive(:destroy!).and_throw(StandardError)

        delete achievement_path(achievement)
      end

      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'sets the error flash' do
        expect(flash[:error].present?).to be true
      end
    end
  end

  describe 'POST #submit' do
    context 'with valid params' do
      let(:achievement) { nil }
      let(:self_verification_info) { 'hello world' }

      before do
        achievement

        post submit_achievements_path, params: {
          achievement: {
            activity_id: activity.id,
            self_verification_info:
          }
        }
      end

      it 'returns a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'sets the success flash' do
        expect(flash[:notice].present?).to be true
      end

      it 'creates an achievement' do
        expect(user.achievements.empty?).to be false
      end

      it 'creates achievement in completed state' do
        expect(user.achievements.first.complete?).to be true
      end

      context 'when activity already exists' do
        let(:achievement) { create(:drafted_achievement, self_verification_info: 'hello world', user:, activity:) }

        it 'updates achievement to completed state' do
          expect(achievement.complete?).to be true
        end
      end

      context 'if inadequate evidience is provided' do
        let(:self_verification_info) { nil }

        it 'sets flash to inform of this' do
          expect(flash[:notice]).to eq 'Inadequate evidence provided'
        end
      end
    end

    context 'with invalid params' do
      before do
        post submit_achievements_path, params: {
          achievement: {
            activity_id: nil,
            self_verification_info: 'hello world'
          }
        }
      end

      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'sets the error flash' do
        expect(flash[:error].present?).to be true
      end
    end
  end
end
