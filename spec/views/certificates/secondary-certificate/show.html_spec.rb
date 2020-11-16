require 'rails_helper'

RSpec.describe('certificates/secondary_certificate/show', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'secondary-certificate') }
  let(:assessment) { create(:assessment, programme_id: programme.id) }
  let(:programme_activity_groupings) { create_list(:programme_activity_grouping, 3, :with_activities, programme_id: programme.id) }

  before do
    assessment
    @current_user = user
    @programme = programme
    @programme_activity_groupings = programme_activity_groupings
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @user_programme_achievements = instance_double('UserProgrammeAchievements')
    allow(@user_programme_achievements).to receive_messages(online_achievements: [],
                                                            face_to_face_achievements: [])
  end

  it 'has the hero' do
    byebug
    expect(rendered).to have_css('.hero__heading', text: programme.title)
  end

  # it 'has the title' do
  #   expect(rendered).to have_css('.ncce-programmes-activity__title', text: 'Your progress')
  # end

  # it 'has correct list setup' do
  #   expect(rendered).to have_css('.ncce-activity-list--programme', count: 3)
  # end
end
