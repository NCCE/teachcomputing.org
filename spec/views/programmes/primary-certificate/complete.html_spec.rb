require 'rails_helper'

RSpec.describe('programmes/primary-certificate/complete', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'primary-certificate') }
  let(:enrolment) { create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id) }

  before do
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    assign(:complete_achievements, user.achievements.for_programme(programme).sort_complete_first)
    enrolment.transition_to(:complete)
    render
  end

  it 'has a status' do
    expect(rendered).to have_css('.status-block', text: 'Certificate awarded')
  end

  it 'has the programme title' do
    expect(rendered).to have_css('.hero__heading', text: @programme.title)
  end

  it 'has the download button' do
    expect(rendered).to have_link('Download your certificate', href: '/certificate/primary-certificate/view-certificate')
  end

  it 'has the journey section' do
    expect(rendered).to have_css('.ncce-programmes-activity__title', text: 'Your learning journey')
  end

  it 'has the Twitter section' do
    expect(rendered).to have_css('.ncce-aside__title', text: 'Share your success')
  end

  it 'has the roa' do
    expect(rendered).to have_css('.primary-certificate__complete', count: 1)
  end
end
