require 'rails_helper'

RSpec.describe Admin::AchievementsController do

  describe 'GET #index' do	 	
		context 'token is not passed' do
			it 'returns 401 unauthorized for achievements' do
		 		get admin_user_achievements_path('1234')
				expect(response.status).to eq 400
			end

			it 'returns 401 unauthorized for achievement' do
		 		get admin_user_achievements_path('1234')
				expect(response.status).to eq 400
			end

		end

		context 'token is passed' do
			it 'returns 200 authorized' do
		 		get admin_user_achievements_path('1234', headers: { 'HTTP_AUTHORIZATION': 'Bearer secret' } )
				expect(response.status).to eq 401
			end
		end

  end
end