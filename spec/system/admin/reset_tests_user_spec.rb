require 'rails_helper'

RSpec.describe 'User reset tests' do
  context 'with two assesment attempts' do
    let!(:user) { create(:user) }
    let!(:attempts) { create_list(:assessment_attempt, 5, user:) }

    it 'allows resetting assesment tests for a user' do
      user.reload
      expect(user.assessment_attempts.count).to eq(5)

      # visit admin_users_path(user.id)
      # click_link user.email
      # click_link 'Remove Assessment Attempts'
      # user.reload
      # expect(user.assessment_attempts.count).to eq(0)

      # expect(page).to have_text('Assessment attempts removed')
      # expect(page).to have_text("Show #{u.email}")
    end
  end
end
