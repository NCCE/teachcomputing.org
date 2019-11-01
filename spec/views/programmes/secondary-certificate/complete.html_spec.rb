require 'rails_helper'

RSpec.describe('programmes/secondary-certificate/complete', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'secondary-certificate') }

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

  it 'has a status' do
    expect(rendered).to have_css('.hero__status', text: 'Certificate awarded')
  end

  it 'has the programme title' do
    expect(rendered).to have_css('.hero__heading', text: @programme.title)
  end

  it 'has the download button' do
    expect(rendered).to have_link('View your certificate', href: '/certificate/secondary-certificate/view-certificate')
  end

  it 'has the journey section' do
    expect(rendered).to have_css('.ncce-programmes-activity__title', text: 'Your learning journey')
  end

  it 'has the Twitter section' do
    expect(rendered).to have_css('.ncce-aside__title', text: 'Share your success')
  end

  it 'has the Twitter share button' do
    expect(rendered).to have_css('.button--aside', text: 'Tweet your certificate')
  end

  it 'has the roa' do
    expect(rendered).to have_css('.ncce-activity-list', count: 3)
  end
end
