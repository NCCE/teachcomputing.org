require 'rails_helper'

RSpec.describe('programmes/primary-certificate/show', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'primary-certificate') }
  let(:assessment) { create(:assessment, programme_id: programme.id) }

  before do
    assessment
    @current_user = user
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @user_programme_achievements = instance_double('UserProgrammeAchievements')
    allow(@user_programme_achievements).to receive_messages(online_achievements: [],
                                                            face_to_face_achievements: [],
                                                            diagnostic_achievements: [],
                                                            community_activities: [])
    @user_programme_assessment = instance_double('UserProgrammeAssessment')
    allow(@user_programme_assessment).to receive_messages(enough_credits_for_test?: false)
    render
  end

  it 'has the hero' do
    expect(rendered).to have_css('.hero__heading', text: programme.title)
  end

  it 'has the title' do
    expect(rendered).to have_css('.govuk-body-l', text: /^Welcome to the Teach primary computing programme!/)
  end

  it 'has correct list setup' do
    expect(rendered).to have_css('.ncce-activity-list--programme', count: 3)
  end
end
