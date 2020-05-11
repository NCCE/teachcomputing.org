require 'rails_helper'

RSpec.describe('programmes/cs-accelerator/show', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:assessment) { create(:assessment, programme_id: programme.id) }

  before do
    assessment
    @current_user = user
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @user_programme_achievements = instance_double('UserProgrammeAchievements')
    allow(@user_programme_achievements).to receive_messages(online_achievements: [], face_to_face_achievements: [], diagnostic_achievements: [])
    @user_programme_assessment = instance_double('UserProgrammeAssessment')
    allow(@user_programme_assessment).to receive_messages(enough_credits_for_test?: false)
    render
  end

  it 'has one heading' do
    expect(rendered).to have_css('.govuk-heading-s', count: 1)
  end
end
