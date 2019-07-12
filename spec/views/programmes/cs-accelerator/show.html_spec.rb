require 'rails_helper'

RSpec.describe('programmes/cs-accelerator/show', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:assessment) { create(:assessment, programme_id: programme.id) }

  before do
    assessment
    @current_user = user
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    render
  end

  it 'has activities in the list' do
    expect(rendered).to have_css('.ncce-activity-list__item', count: 8)
  end
end
