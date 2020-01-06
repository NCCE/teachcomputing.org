require 'rails_helper'

RSpec.describe('programmes/primary-certificate/show', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }

  before do
    @current_user = user
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    allow_any_instance_of(Programmes::PrimaryCertificate).to receive(:diagnostic_result).and_return(15)
    @user_programme_achievements = instance_double('UserProgrammeAchievements')
    allow(@user_programme_achievements).to receive_messages(online_achievements: [],
                                                            face_to_face_achievements: [],
                                                            diagnostic_achievements: [],
                                                            community_activities: [])
    render
  end

  it 'has the hero' do
    expect(rendered).to have_css('.hero__heading', text: programme.title)
  end

  it 'has the title' do
    expect(rendered).to have_css('.govuk-body-l', text: /^Welcome to the Teach primary computing programme!/)
  end

  it 'has correct list setup' do
    expect(rendered).to have_css('.ncce-activity-list--programme', count: 4)
  end
end
