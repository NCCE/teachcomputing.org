require 'rails_helper'

RSpec.describe Admin::AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
	let(:programme) { create(:programme) }
	let(:achievement) { create(:achievement, user: user, programme: programme) }
  let(:token_headers) { { 'HTTP_AUTHORIZATION': 'Bearer secret', 'HTTP_CONTENT_TYPE': 'application/json' } }

  context 'token is not passed' do
    describe 'POST #create' do
      before do
        post "/admin/users/#{user.id}/achievements/", { params: { activity_id: activity.id }, headers: nil }
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    describe 'POST #complete' do
      before do
        post "/admin/users/#{user.id}/achievements/#{achievement.id}/complete", { headers: nil }
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end
  end

  context 'token is passed' do
    describe 'POST #create' do
      before do
        post "/admin/users/#{user.id}/achievements/", { params: { activity_id: activity.id }, headers: token_headers }
      end

      it 'returns 201 status' do
        expect(response.status).to eq 201
      end

      it 'returns the new achievement' do
        expect(JSON.parse(response.body)['activity']['title']).to eq activity.title
      end

      it 'check for duplication' do
				post "/admin/users/#{user.id}/achievements/", { params: { activity_id: activity.id }, headers: token_headers }
        expect(response.status).to eq 409
      end
    end

    describe 'POST #complete' do
      before do
        post "/admin/users/#{user.id}/achievements/#{achievement.id}/complete", { headers: token_headers }
      end

      it 'returns 201 status' do
        expect(response.status).to eq 201
      end

      it 'returns the achievement' do
        expect(JSON.parse(response.body)['id']).to eq achievement.id
      end

      it 'returns achievement current_state' do
        expect(JSON.parse(response.body)['current_state']).to eq 'complete'
      end
    end
  end
end
