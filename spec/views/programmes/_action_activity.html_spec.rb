require 'rails_helper'

RSpec.describe('programmes/_action', type: :view) do
  let!(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @programme = programme
    render
  end

  it 'has activities in the list' do
    expect(rendered).to have_css('.ncce-activity-list__item', count: 7)
  end

  it 'some of the activities are incomplete' do
    expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 6)
  end

  it 'incomplete activities have buttons' do
    expect(rendered).to have_css('.ncce-button__pink--rounded', count: 5)
  end
end
