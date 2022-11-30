require 'rails_helper'

RSpec.describe 'User reset tests' do
  before do
    ENV['BYPASS_ADMINISTRATE_CF_AUTH'] = 'true'
    stub_delegate
  end

  after do
    ENV['BYPASS_ADMINISTRATE_CF_AUTH'] = 'false'
  end

  it 'allows resetting tests for a user' do
    u = create(:user)
    visit admin_users_path(u.id)
    click_link u.email
    click_link 'Remove Assessment Attempts'

    expect(page).to have_text('Assessment attempts removed')
    expect(page).to have_text("Show #{u.email}")
  end
end
