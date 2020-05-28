require 'rails_helper'

RSpec.describe Admin::AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
	let(:programme) { create(:programme) }
	let(:achievement) { 
		create(:achievement, user: user, programme: programme)
	}
  let(:token_headers) { { 'HTTP_AUTHORIZATION': 'Bearer secret', 'HTTP_CONTENT_TYPE': 'application/json' } }

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


    describe 'GET #show' do
      before do
        get "/admin/users/#{user.id}/achievements/#{achievement.id}", { headers: nil }
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

			it 'returns user email' do
        expect(JSON.parse(response.body).first['user']['email']).to eq user.email
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
        expect(JSON.parse(response.body)['activity']['title']).to eq activity.title
      end

      it 'check for duplication' do
				post "/admin/users/#{user.id}/achievements/", { params: { activity_id: activity.id }, headers: token_headers }
        expect(response.status).to eq 409
      end
    end

    describe 'GET #show' do
      it 'returns 200 status' do
				get "/admin/users/#{user.id}/achievements/#{achievement.id}", { headers: token_headers }
        expect(response.status).to eq 200
      end

			it 'returns the new achievement' do
				get "/admin/users/#{user.id}/achievements/#{achievement.id}", { headers: token_headers }
        expect(JSON.parse(response.body)['id']).to eq achievement.id
      end

      it 'raises an error for invalid achievement' do
				expect {
					get "/admin/users/#{user.id}/achievements/invalid", { headers: token_headers }
				}.to raise_error(ActiveRecord::RecordNotFound)
      end 

      it 'returns achievement current_state' do
				get "/admin/users/#{user.id}/achievements/#{achievement.id}", { headers: token_headers }
        expect(JSON.parse(response.body)['current_state']).to eq achievement.current_state
      end

			it 'returns programme title' do
				get "/admin/users/#{user.id}/achievements/#{achievement.id}", { headers: token_headers }
        expect(JSON.parse(response.body)['programme']['title']).to eq programme.title
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

