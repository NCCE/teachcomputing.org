require 'rails_helper'

RSpec.describe 'Admin::AchievementsController' do
  let(:user) { create(:user) }
  let(:achievement) { create(:achievement, user:) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return('user@example.com')
  end

  describe 'GET #index' do
    before do
      get admin_achievements_path
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    before do
      get admin_achievement_path(achievement)
    end

    it 'renders the correct template' do
      expect(response).to render_template('show')
    end
  end

  describe 'DETELE #delete' do
    before do
      delete admin_achievement_path(achievement)
    end

    it 'should redirect to user page after deleting' do
      expect(response).to redirect_to(admin_user_path(user))
    end
  end
end
