require 'rails_helper'

RSpec.describe('programmes/_cs-accelerator', type: :view) do
  let!(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:assessment) { create(:assessment, programme_id: programme.id) }

  before do
    assessment
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @programme = programme
    render
  end

  it 'has activities in the list' do
    expect(rendered).to have_css('.ncce-activity-list__item', count: 8)
  end

end
