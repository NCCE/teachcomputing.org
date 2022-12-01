require 'rails_helper'

RSpec.describe 'User reset tests' do
  context 'with two assesment attempts' do
    let(:user) { create(:user) }
    let(:attempts) { create_list(:assesment_attempts, 5, user:) }

    it 'allows resetting assesment tests for a user' do
      visit admin_users_path(user.id)
      click_link user.email
      expect(user.assessment_attempts.count).to equal(5)
      click_link 'Remove Assessment Attempts'
      user.reload
      expect(user.assessment_attempts.count).to equal(0)
      # expect(page).to have_text('Assessment attempts removed')
      # expect(page).to have_text("Show #{u.email}")
    end
  end
end
