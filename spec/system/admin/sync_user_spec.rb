require 'rails_helper'

RSpec.describe 'Stem user sync', type: :system do
  before do
    stub_delegate
  end

  it 'allows syncing a user' do
    u = create(:user)
    visit admin_users_path(u.id)
    click_link u.email
    click_link 'Sync with Stem'

    # expect(page).to redirect_to(admin_users_path(u.id))
    expect(page).to have_text('Sync complete')
    expect(page).to have_text("Show #{u.email}")
  end
end
