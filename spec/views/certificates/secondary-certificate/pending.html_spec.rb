require 'rails_helper'

RSpec.describe('certificates/secondary_certificate/pending', type: :view) do
  let(:user) { create(:user) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:enrolment) { create(:user_programme_enrolment, programme_id: secondary_certificate.id, user_id: user.id) }

  before do
    @programme = secondary_certificate
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    assign(:complete_achievements, user.achievements.for_programme(secondary_certificate).sort_complete_first)
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
