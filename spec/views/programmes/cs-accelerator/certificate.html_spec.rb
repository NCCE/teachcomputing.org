require 'rails_helper'

RSpec.describe('programmes/cs-accelerator/certificate', type: :view) do
  let!(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:achievement) { create(:achievement) }

  before do
    # assessment
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @programme = programme
    achievement.set_to_complete(certificate_number: 0)
    @transition = achievement.last_transition
    @transition.created_at = DateTime.parse('2001-02-03T04:05:06')
    render
  end

  it 'has programme name' do
    expect(rendered).to have_css('h1', text: programme.title)
  end

  it 'has the passed date correctly' do
    expect(rendered).to have_css('.govuk-list li strong', text: '03/02/2001')
  end
end
