require 'rails_helper'

RSpec.describe 'User reset tests' do
  context 'with two assesment attempts' do
    let(:user) { create(:user) }

    before do
      create_list(:assessment_attempt, 5, user:)
      visit admin_users_path(user.id)
      click_link user.email
      click_link 'Remove Assessment Attempts'
    end

    it 'allows resetting assesment tests for a user' do
      # TODO: Why do the next two tests pass? Shouldn't we be taken to an audit page?
      expect(page).to have_text('Assessment attempts removed')
      expect(page).to have_text("Show #{user.email}")
      expect(user.assessment_attempts.count).to eq(0)
    end
  end
end
