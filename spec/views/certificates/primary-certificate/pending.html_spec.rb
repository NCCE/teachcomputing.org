require 'rails_helper'

RSpec.describe('certificates/primary_certificate/pending', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'primary-certificate') }
  let(:enrolment) { create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id) }

  before do
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    assign(:complete_achievements, user.achievements.belongs_to_programme(programme).sort_complete_first)
    enrolment.transition_to(:pending)
    render
  end

  it 'has the programme title' do
    expect(rendered).to have_css('.govuk-body-l', text: 'Well done! You have completed the programme')
  end

  it 'has the roa' do
    expect(rendered).to have_css('.ncce-activity-list', count: 1)
  end
end
