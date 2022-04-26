require 'rails_helper'

RSpec.describe UserProgrammeAchievements do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:community_activity) { create(:activity, :community_5) }

  let(:setup_achievements_for_programme) do
    user_programme_enrolment
    create(:programme_activity, programme_id: programme.id, activity_id: community_activity.id)
  end

  let(:user_programme_achievements) { described_class.new(programme, user) }

  describe 'presenters are correct' do
    it 'community_activities contains CommunityPresenters' do
      expect(user_programme_achievements.community_activities.first).to be_a(CommunityPresenter)
    end
  end

  describe 'when the user has some achievements' do
    before do
      setup_achievements_for_programme
    end

    it 'community_activities includes the community activity' do
      expect(user_programme_achievements.community_activities).to include(community_activity)
    end
  end
end
