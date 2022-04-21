require 'rails_helper'

RSpec.describe UserProgrammeAchievements do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }

  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }

  let(:online_course) { create(:activity, :future_learn, credit: 20) }
  let(:online_achievement) { create(:achievement, user_id: user.id, activity_id: online_course.id) }
  let(:face_to_face_course) { create(:activity, :stem_learning, credit: 20) }
  let(:face_to_face_achievement) { create(:achievement, user_id: user.id, activity_id: face_to_face_course.id) }
  let(:community_activity) { create(:activity, :community_5) }

  let(:setup_achievements_for_programme) do
    user_programme_enrolment
    activities = [online_course, face_to_face_course, community_activity]

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
    end

    online_achievement
    face_to_face_achievement
  end

  let(:setup_mixed_achievements) do
    setup_achievements_for_programme
    activities = [create(:activity, :future_learn, credit: 20), create(:activity, :future_learn, credit: 20)]

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      create(:completed_achievement, user_id: user.id, activity_id: activity.id)
    end
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

    it 'online_achievements includes the online achievement' do
      expect(user_programme_achievements.online_achievements).to include(online_achievement)
    end

    it 'face_to_face achievements includes the face_to_face_achievement' do
      expect(user_programme_achievements.face_to_face_achievements).to include(face_to_face_achievement)
    end

    it 'community_activities includes the community activity' do
      expect(user_programme_achievements.community_activities).to include(community_activity)
    end
  end

  describe 'when the user has achievements in varying states' do
    before do
      setup_mixed_achievements
    end

    it 'only shows complete or in progress achievements' do
      user_programme_achievements.online_achievements.each do |a|
        expect(a.current_state).not_to eq('dropped')
      end
    end
  end
end
