require 'rails_helper'

RSpec.describe Programmes::CSAccelerator do
  let(:programme) { create(:cs_accelerator) }
  let(:diagnostic) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  let(:online_courses) { create_list(:activity, 2, :future_learn, credit: 20) }
  let(:face_to_face_courses) { create_list(:activity, 2, :stem_learning, credit: 20) }
  let(:short_face_to_face_course) { create(:activity, :stem_learning, credit: 10) }
  let(:short_face_to_face_achievement) do
    create(:achievement, user_id: user.id, activity_id: short_face_to_face_course.id)
  end
  let(:another_short_face_to_face_course) { create(:activity, :stem_learning, credit: 10) }
  let(:another_short_face_to_face_achievement) do
    create(:achievement, user_id: user.id, activity_id: another_short_face_to_face_course.id)
  end

  let(:setup_partially_complete_certificate) do
    user_programme_enrolment
    activities = [].concat(online_courses, face_to_face_courses)

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      if activity.category == 'online'
        achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
        achievement.complete!
      end
    end
  end

  let(:setup_complete_certificate) do
    user_programme_enrolment

    activities = [].concat(online_courses, face_to_face_courses)

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
      achievement.complete!
    end
  end

  let(:setup_one_short_f2f_achievement) do
    user_programme_enrolment
    short_face_to_face_course
    create(:programme_activity, programme_id: programme.id, activity_id: short_face_to_face_course.id)
    short_face_to_face_achievement.complete!
  end

  let(:setup_two_short_f2f_achievements) do
    setup_one_short_f2f_achievement
    another_short_face_to_face_course
    create(:programme_activity, programme_id: programme.id, activity_id: another_short_face_to_face_course.id)
    another_short_face_to_face_achievement = create(:achievement, user_id: user.id,
                                                                  activity_id: another_short_face_to_face_course.id)
    another_short_face_to_face_achievement.complete!
  end

  let(:setup_one_online_achievement) do
    user_programme_enrolment
    online_courses
    create(:programme_activity, programme_id: programme.id, activity_id: online_courses[0].id)
    online_achievement = create(:achievement, user_id: user.id, activity_id: online_courses[0].id)
    online_achievement.complete!
  end

  let(:setup_short_f2f_and_online_achievement) do
    setup_one_short_f2f_achievement
    setup_one_online_achievement
  end

  let(:setup_two_online_achievements) do
    activities = online_courses

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
      achievement.complete!
    end
  end

  describe '#pending_delay' do
    it 'should return 7 days' do
      expect(programme.pending_delay).to eq 7.days
    end
  end

  describe '#diagnostic' do
    context 'when an associated diagnostic activity exists' do
      it 'returns record' do
        programme.activities << diagnostic
        expect(programme.diagnostic).to eq diagnostic
      end
    end

    context 'when an associated diagnostic activity doesn\'t exists' do
      it 'returns raises an RecordNotFound' do
        expect do
          programme.diagnostic
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#credits_achieved_for_certificate' do
    context 'when the user has not done any activities' do
      it 'returns 0' do
        expect(programme.credits_achieved_for_certificate(user)).to eq(0)
      end
    end

    context 'when the user has done 1 online activity' do
      before do
        setup_one_online_achievement
      end

      it 'returns 50%' do
        expect(programme.credits_achieved_for_certificate(user)).to eq(50)
      end
    end

    context 'when the user has done 1 short f2f activity' do
      before do
        setup_one_short_f2f_achievement
      end

      it 'returns 50%' do
        expect(programme.credits_achieved_for_certificate(user)).to eq(50)
      end
    end

    context 'when the user has done 2 online activities' do
      before do
        setup_two_online_achievements
      end

      it 'returns 50%' do
        expect(programme.credits_achieved_for_certificate(user)).to eq(50)
      end
    end

    context 'when the user has done 2 short f2f activities' do
      before do
        setup_two_short_f2f_achievements
      end

      it 'returns 100%' do
        expect(programme.credits_achieved_for_certificate(user)).to eq(100)
      end
    end

    context 'when the user has done 1 f2f & 1 online activity' do
      before do
        setup_short_f2f_and_online_achievement
      end

      it 'returns 100%' do
        expect(programme.credits_achieved_for_certificate(user)).to eq(100)
      end
    end
  end

  describe '#max_credits_for_certificate' do
    it 'returns 100 for 10 hour system' do
      expect(programme.max_credits_for_certificate).to eq(100)
    end
  end

  describe '#enough_activities_for_test?' do
    context 'when the user has not done any activities' do
      it 'returns false' do
        expect(programme.enough_activities_for_test?(user)).to eq(false)
      end
    end

    context 'when the user has done 1 online activity' do
      before do
        setup_one_online_achievement
      end

      it 'returns false' do
        expect(programme.enough_activities_for_test?(user)).to eq(false)
      end
    end

    context 'when the user has done 1 short f2f activity' do
      before do
        setup_one_short_f2f_achievement
      end

      it 'returns false' do
        expect(programme.enough_activities_for_test?(user)).to eq(false)
      end
    end

    context 'when the user has done 2 online activities' do
      before do
        setup_two_online_achievements
      end

      it 'returns false' do
        expect(programme.enough_activities_for_test?(user)).to eq(false)
      end
    end

    context 'when the user has done 2 short f2f activities' do
      before do
        setup_two_short_f2f_achievements
      end

      it 'returns true' do
        expect(programme.enough_activities_for_test?(user)).to eq(true)
      end
    end

    context 'when the user has done 1 f2f & 1 online activity' do
      before do
        setup_short_f2f_and_online_achievement
      end

      it 'returns true' do
        expect(programme.enough_activities_for_test?(user)).to eq(true)
      end
    end
  end

  describe '#path' do
    it 'returns the path for the programme' do
      expect(programme.path).to eq('/certificate/cs-accelerator')
    end
  end

  describe '#enrol_path' do
    it 'returns the path for the enrol' do
      expect(programme.enrol_path(user_programme_enrolment: { user_id: 'user_id',
                                                              programme_id: 'programme_id' })).to eq('/certificate/cs-accelerator/enrol?user_programme_enrolment%5Bprogramme_id%5D=programme_id&user_programme_enrolment%5Buser_id%5D=user_id')
    end
  end

  describe '#programme_title' do
    it 'returns correct title' do
      expect(programme.programme_title).to eq('GCSE Computer Science Subject Knowledge')
    end
  end

  describe '#compulsory_achievement' do
    context 'when user has no f2f achievements' do
      it 'returns nil' do
        expect(programme.compulsory_achievement(user)).to eq(nil)
      end
    end

    context 'when user has single f2f achievement' do
      it 'returns the achievement' do
        achievement = create(:achievement, user: user)
        create(:programme_activity, programme:, activity: achievement.activity)
        expect(programme.compulsory_achievement(user)).to eq(achievement)
      end

      it 'ignores dropped achievements' do
        achievement = create(:achievement, user: user)
        achievement.transition_to(:dropped)
        create(:programme_activity, programme:, activity: achievement.activity)
        expect(programme.compulsory_achievement(user)).to eq(nil)
      end
    end

    context 'when user has multiple f2f achievements' do
      let!(:earliest_achievement) do
        create(:achievement, user: user, created_at: Time.now - 7.days)
      end

      let!(:another_achievement) { create(:achievement, user: user) }
      let!(:further_achievement) { create(:achievement, user: user) }

      before do
        [earliest_achievement, another_achievement, further_achievement].each do
          create(:programme_activity, programme:, activity: _1.activity)
        end
      end

      it 'returns the first achievement if none are complete' do
        expect(programme.compulsory_achievement(user)).to eq(earliest_achievement)
      end

      it 'returns the complete achievement if 1 is complete' do
        another_achievement.transition_to(:complete)
        expect(programme.compulsory_achievement(user)).to eq(another_achievement)
      end

      it 'returns the achievement completed first if multiple are complete' do
        further_achievement.transition_to(:complete)
        another_achievement.transition_to(:complete)
        expect(programme.compulsory_achievement(user)).to eq(further_achievement)
      end
    end

    context 'when user has no f2f achievements but has online achievements' do
      it 'returns nil' do
        activity = create(:activity, :online)
        create(:programme_activity, programme_id: programme.id, activity:)
        achievement = create(:achievement, user: user, activity: activity)
        expect(programme.compulsory_achievement(user)).to eq(nil)
      end
    end
  end

  describe '#non_compulsory_achievements' do
    context 'when user has no achievements' do
      it 'returns empty list' do
        expect(programme.non_compulsory_achievements(user)).to eq([])
      end
    end

    context 'when user has non course achievements' do
      it 'does not return other types of achievements' do
        [
          create(:achievement, activity: create(:activity, category: 'action'), user: user),
          create(:achievement, activity: create(:activity, category: 'assessment'), user: user),
          create(:achievement, activity: create(:activity, category: 'community'), user: user),
          create(:achievement, activity: create(:activity, category: 'diagnostic'), user: user)
        ].each { create(:programme_activity, programme: programme, activity: _1.activity) }

        expect(programme.non_compulsory_achievements(user)).to eq([])
      end
    end

    context 'when user has compulsory achievement but no others' do
      it 'returns empty list' do
        achievement = create(:achievement, user: user)
        create(:programme_activity, programme_id: programme.id, activity: achievement.activity)
        expect(programme.non_compulsory_achievements(user)).to eq([])
      end
    end

    context 'when user has no f2f achievements but does have online achievements' do
      it 'returns online achievements' do
        achievements = [
          create(:achievement,:online, user: user),
          create(:achievement,:online, user: user)
        ]
        achievements.each { create(:programme_activity, activity: _1.activity, programme: ) }
        expect(programme.non_compulsory_achievements(user)).to match_array(achievements)
      end
    end

    context 'when user has f2f achievements and online achievements' do
      it 'returns online achievements and f2f achievements except the first one' do
        f2f_achievements = create_list(:achievement, 2, user: user)
        first = create(:achievement, user: user, created_at: Time.now - 7.days)
        online_achievements = create_list(:achievement, 2, :online, user: user)
        [*f2f_achievements, first, *online_achievements].each do
          create(:programme_activity, activity: _1.activity, programme: )
        end
        results = programme.non_compulsory_achievements(user)
        expect(results).to match_array(f2f_achievements + online_achievements)
      end

      it 'ignores dropped achievements' do
        f2f_achievements = create_list(:achievement, 2, user: user)
        first = create(:achievement, user: user, created_at: Time.now - 7.days)
        online_achievements = create_list(:achievement, 2, :online, user: user)
        dropped_achievement = create(:achievement, user: user)
        dropped_achievement.transition_to(:dropped)
        [*f2f_achievements, first, *online_achievements, dropped_achievement].each do
          create(:programme_activity, activity: _1.activity, programme: )
        end
        results = programme.non_compulsory_achievements(user)
        expect(results).not_to include(dropped_achievement)
      end
    end
  end

  describe '#user_completed_non_compulsory_achievement?' do
    context 'when user has no achievements' do
      it 'returns false' do
        expect(programme.user_completed_non_compulsory_achievement?(user)).to eq(false)
      end
    end

    context 'when user has no complete non compulsory achievement' do
      it 'returns false' do
        achievements = create_list(:achievement, 2, :online, user: user)
        expect(programme.user_completed_non_compulsory_achievement?(user))
          .to eq(false)
      end
    end

    context 'when user at least one complete non compulsory achievement' do
      it 'returns true' do
        f2f_achievements = create_list(:achievement, 2, user: user)
        compulsory_achievement = create(:achievement, user: user, created_at: Time.now - 7.days)
        compulsory_achievement.transition_to(:complete)
        online_achievement = create(:achievement, :online, user: user)
        online_achievement.transition_to(:complete)
        [*f2f_achievements, compulsory_achievement, online_achievement].each do
          create(:programme_activity, activity: _1.activity, programme: )
        end
        expect(programme.user_completed_non_compulsory_achievement?(user))
          .to eq(true)
      end
    end

    context 'when user completed compulsory but not non compulsory achievement' do
      it 'returns false' do
        f2f_achievements = create_list(:achievement, 2, user: user)
        compulsory_achievement = create(:achievement, user: user, created_at: Time.now - 7.days)
        compulsory_achievement.transition_to(:complete)
        online_achievement = create(:achievement, :online, user: user)
        [*f2f_achievements, compulsory_achievement, online_achievement].each do
          create(:programme_activity, activity: _1.activity, programme: )
        end
        expect(programme.user_completed_non_compulsory_achievement?(user))
          .to eq(false)
      end
    end
  end

  describe '#short_name' do
    it 'should return its short name' do
      expect(programme.short_name).to eq 'CS Accelerator'
    end
  end
end
