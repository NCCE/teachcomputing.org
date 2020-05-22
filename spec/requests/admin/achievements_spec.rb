require 'rails_helper'

RSpec.describe Admin::AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:achievement) { create(:achievement, user: user) }
  let(:token_headers) { { 'HTTP_AUTHORIZATION': 'Bearer secret', 'HTTP_CONTENT_TYPE': 'application/json' } }

  # This is a crude method to run before / after each test
  # we may need to actually have some achievements for a user / activity
  # but we can possibly do those in specific test 'before' blocks?
  before do
    Achievement.where(user: user).destroy_all
  end

  after do
    Achievement.where(user: user).destroy_all
  end

  context 'token is not passed' do
    describe 'GET #index' do
      it 'returns 401 status' do
        get admin_user_achievements_path(user.id)
        expect(response.status).to eq 401
      end
    end

    describe 'POST #create' do
      before do
        post "/admin/users/#{user.id}/achievements/", { params: { activity_id: activity.id }, headers: nil }
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end
  end

  context 'token is passed' do
    describe 'GET #index' do
      before do
        achievement
        get "/admin/users/#{user.id}/achievements", { headers: token_headers }
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      it 'returns one item in an array' do
        expect(JSON.parse(response.body).count).to eq 1
      end

      it 'returns the right achievement' do
        expect(JSON.parse(response.body).first['id']).to eq achievement.id
      end
    end

    describe 'POST #create' do
      before do
        post "/admin/users/#{user.id}/achievements/", { params: { activity_id: activity.id }, headers: token_headers }
      end

      it 'returns 201 status' do
        expect(response.status).to eq 201
      end

      it 'returns the new achievement' do
        expect(JSON.parse(response.body)['activity_id']).to eq activity.id
      end
    end
  end
end
