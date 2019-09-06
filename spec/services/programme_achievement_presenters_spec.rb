require 'rails_helper'

RSpec.describe ProgrammeAchievementPresenters do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:non_enrollable_programme) { create(:programme, slug: 'non-enrollable', enrollable: false) }

  let(:assessment) { create(:assessment, programme_id: programme.id) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

  let(:diagnostic_tool_activity) { create(:activity, :diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }
  let(:online_course) { create(:activity, :future_learn, credit: 20) }
  let(:online_achievement) { create(:achievement, user_id: user.id, activity_id: online_course.id) }
  let(:face_to_face_course) { create(:activity, :stem_learning, credit: 20) }
  let(:face_to_face_achievement) { create(:achievement, user_id: user.id, activity_id: face_to_face_course.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam )}
  let(:exam_programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  let(:setup_achievements_for_programme) do
    assessment
    user_programme_enrolment
    activities = [diagnostic_tool_activity, online_course, face_to_face_course]

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
    end
    diagnostic_achievement
    online_achievement
    face_to_face_achievement
  end

  let(:setup_mixed_achievements) do
    setup_achievements_for_programme
    activities = [create(:activity, :future_learn, credit: 20), create(:activity, :future_learn, credit: 20)]

    activities.each do |activity|
      create(:completed_achievement, user_id: user.id, activity_id: activity.id)
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
    end
  end

  let(:programme_achievement_presenters) { ProgrammeAchievementPresenters.new.create(programme, user) }

  describe 'attr_accessor' do
    it 'online_achievements returns an Array' do
      expect(programme_achievement_presenters.online_achievements).to be_an(Array)
    end

    it 'face_to_face_achievements returns an Array' do
      expect(programme_achievement_presenters.face_to_face_achievements).to be_an(Array)
    end

    it 'diagnostic_achievements returns an Array' do
      expect(programme_achievement_presenters.diagnostic_achievements).to be_an(Array)
    end
  end

  describe 'presenters are correct' do
    it 'online_achievements contains OnlinePresenters' do
      expect(programme_achievement_presenters.online_achievements.first).to be_an(OnlinePresenter)
    end

    it 'face_to_face_achievements contains FaceToFacePresenters' do
      expect(programme_achievement_presenters.face_to_face_achievements.first).to be_a(FaceToFacePresenter)
    end

    it 'diagnostic_achievements contains DiagnosticPresenters' do
      expect(programme_achievement_presenters.diagnostic_achievements.first).to be_a(DiagnosticPresenter)
    end
  end

  describe 'when the user has some achievements' do
    before do
      setup_achievements_for_programme
    end

    it 'online_achievements includes the online achievement' do
      expect(programme_achievement_presenters.online_achievements).to include(online_achievement)
    end

    it 'face_to_face achievements includes the face_to_face_achievement' do
      expect(programme_achievement_presenters.face_to_face_achievements).to include(face_to_face_achievement)
    end

    it 'diagnostic_achievements includes the diagnostic achievement' do
      expect(programme_achievement_presenters.diagnostic_achievements).to include(diagnostic_achievement)
    end
  end

  describe 'when the user has 1 in-progress and 2 complete achievements' do
    before do
      setup_mixed_achievements
    end

    it 'doesn\'t show in-progress achievements' do
      expect(programme_achievement_presenters.online_achievements).to_not include(online_achievement)
    end

    it 'only shows complete achievements' do
      programme_achievement_presenters.online_achievements.each do |a|
        expect(a.current_state).to eq('complete')
      end
    end
  end
end
