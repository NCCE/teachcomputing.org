require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Dashboard page', type: :system) do
  let(:user) { create(:user) }

  before do
		create(:primary_certificate)
		create(:cs_accelerator)
		create(:secondary_certificate)
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    visit dashboard_path
  end

  it 'is the correct page' do
    expect(page).to have_content("Your dashboard")
  end

  it 'main is accessible' do
    # Remove .ncce-link exclusion when https://github.com/NCCE/teachcomputing.org-issues/issues/858 addressed.
    expect(page).to be_accessible.within('#main-content').excluding('.ncce-link')
  end
end
