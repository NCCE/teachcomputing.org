require 'rails_helper'

RSpec.describe('programmes/_exam_activity', type: :view) do
  let!(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:assessment) { create(:assessment, programme_id: programme.id) }

  before do
    assessment
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @programme = programme
    render
  end

  it 'shows the exam activity information' do
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Pass the final test')
  end

  it 'shows the exam activity points' do
    expect(rendered).to have_css('ul>li', count: 6)
  end

  # context 'when user has not downloaded the diagnostic' do
  #   before do
  #     render
  #   end

  #   it 'diagnostic achievement is  marked as incomplete' do
  #     expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 1)
  #   end
  # end

end
