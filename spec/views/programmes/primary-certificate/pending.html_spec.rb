require 'rails_helper'

RSpec.describe('programmes/primary-certificate/pending', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'primary-certificate') }

  before do
    allow_any_instance_of(Programme).to receive(:user_completed?).and_return(true)
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    user_programme_achievements = instance_double('UserProgrammeAchievements')
    allow(user_programme_achievements).to receive_messages(online_achievements: [],
                                                           face_to_face_achievements: [],
                                                           diagnostic_achievements: [],
                                                           community_activities: [])
    assign(:user_programme_achievements, user_programme_achievements)
    render
  end

  it 'has the programme title' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'Well done! You have completed the programme')
  end

  it 'has the roa' do
    expect(rendered).to have_css('.primary-certificate__complete', count: 1)
  end
end
