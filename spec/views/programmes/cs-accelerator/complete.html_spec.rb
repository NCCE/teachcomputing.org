require 'rails_helper'

RSpec.describe('programmes/cs-accelerator/complete', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }

  before do
    allow_any_instance_of(Programme).to receive(:user_completed?).and_return(true)
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @user_programme_achievements = instance_double('UserProgrammeAchievements')
    allow(@user_programme_achievements).to receive_messages(online_achievements: [], face_to_face_achievements: [], diagnostic_achievements: [])
    render
  end

  it 'has a status' do
    expect(rendered).to have_css('.hero__status', text: 'You have completed')
  end

  it 'has the programme title' do
    expect(rendered).to have_css('.hero__heading', text: @programme.title)
  end

  it 'has the download button' do
    expect(rendered).to have_link('View your certificate', href: '/certificate/cs-accelerator/view-certificate')
  end

  it 'has the journey section' do
    expect(rendered).to have_css('.ncce-programmes-activity__title', text: 'Your learning journey')
  end

  it 'has the Twitter section' do
    expect(rendered).to have_css('.ncce-aside__title', text: 'Share your success')
  end

  it 'has the Twitter share button' do
    expect(rendered).to have_link('Tweet your certificate', href: 'https://twitter.com/intent/tweet?text=I%20have%20completed%20the%20Computer%20Science%20Accelerator%20Programme%20from%20%40WeAreComputing.%20Sign%20up:%20https://teachcomputing.org%2Fcs-accelerator')
  end

  it 'has the roa' do
    expect(rendered).to have_css('.ncce-activity-list', count: 3)
  end
end
