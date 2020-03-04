require 'rails_helper'

RSpec.describe UserProgrammeAssessment do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:non_enrollable_programme) { create(:programme, slug: 'non-enrollable', enrollable: false) }

  let(:assessment) { create(:assessment, programme_id: programme.id) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

  let(:diagnostic_tool_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
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

  let(:setup_achievements_for_taking_test) do
    setup_achievements_for_programme
    online_achievement.set_to_complete
    face_to_face_achievement.set_to_complete
    activities = [create(:activity, :future_learn, credit: 20), create(:activity, :stem_learning, credit: 20)]

    activities.each do |activity|
      create(:completed_achievement, user_id: user.id, activity_id: activity.id)
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
    end
  end

  let(:one_commenced_test_attempt) do
    setup_achievements_for_taking_test
    create(:assessment_attempt, user_id: user.id, assessment_id: assessment.id)
  end

  let(:one_failed_test_attempt) do
    setup_achievements_for_taking_test
    create(:failed_assessment_attempt, user_id: user.id, assessment_id: assessment.id)
  end

  let(:two_failed_test_attempts) do
    setup_achievements_for_taking_test
    create_list(:failed_assessment_attempt, 2, user_id: user.id, assessment_id: assessment.id)
  end

  let(:two_old_failed_test_attempts) do
    setup_achievements_for_taking_test
    create_list(:failed_assessment_attempt_from_before, 2, user_id: user.id, assessment_id: assessment.id)
  end

  let(:user_programme_asessment) { UserProgrammeAssessment.new(programme, user) }

  describe 'and enrolled' do
    before do
      setup_achievements_for_programme
    end

    it 'assigns the test gate correctly' do
      expect(user_programme_asessment.enough_credits_for_test?).to eq (false)
    end

    it 'assign the time until user can take the test correctly' do
      expect(user_programme_asessment.can_take_test_at).to eq (0)
    end

    it 'assign whether user is currently doing a test correctly' do
      expect(user_programme_asessment.currently_taking_test?).to eq (false)
    end

    it 'assigns the number of attempts at test correctly' do
      expect(user_programme_asessment.num_attempts).to eq (0)
    end

    it 'assigns the new test gate correctly' do
      expect(user_programme_asessment.enough_activites_for_test?).to eq (false)
    end

    context 'when user can take the test' do
      before do
        setup_achievements_for_taking_test
      end

      it 'assigns the test gate correctly' do
        expect(user_programme_asessment.enough_credits_for_test?).to eq (true)
      end

      it 'assigns the time until user can take the test' do
        expect(user_programme_asessment.can_take_test_at).to eq (0)
      end

      it 'assigns that user is not currently doing a test' do
        expect(user_programme_asessment.currently_taking_test?).to eq (false)
      end

      it 'assigns the number of attempts at test correctly' do
        expect(user_programme_asessment.num_attempts).to eq (0)
      end

      it 'assigns the new test gate correctly' do
        expect(user_programme_asessment.enough_activites_for_test?).to eq (true)
      end
    end

    context 'when user started the test' do
      before do
        one_commenced_test_attempt
      end

      it 'assigns the test gate correctly' do
        expect(user_programme_asessment.enough_credits_for_test?).to eq (true)
      end

      it 'assigns the time until user can take the test' do
        expect(user_programme_asessment.can_take_test_at).to eq (0)
      end

      it 'assigns whether user is currently doing a test' do
        expect(user_programme_asessment.currently_taking_test?).to eq (true)
      end

      it 'assigns the number of attempts at test correctly' do
        expect(user_programme_asessment.num_attempts).to eq (1)
      end
    end

    context 'when user failed the test' do
      before do
        one_failed_test_attempt
      end

      it 'assigns the test gate correctly' do
        expect(user_programme_asessment.enough_credits_for_test?).to eq (true)
      end

      it 'assigns the time until user can take the test' do
        expect(user_programme_asessment.can_take_test_at).to eq (0)
      end

      it 'assigns whether user is currently doing a test' do
        expect(user_programme_asessment.currently_taking_test?).to eq (false)
      end

      it 'assigns the number of attempts at test correctly' do
        expect(user_programme_asessment.num_attempts).to eq (1)
      end
    end

    context 'when user failed the test twice' do
      before do
        two_failed_test_attempts
      end

      it 'assigns the test gate correctly' do
        expect(user_programme_asessment.enough_credits_for_test?).to eq (true)
      end

      it 'assigns the time until user can take the test - 48 hours - 172800 seconds' do
        expect(user_programme_asessment.can_take_test_at).to_not eq 0
      end

      it 'assigns the number of attempts at test correctly' do
        expect(user_programme_asessment.num_attempts).to eq (2)
      end
    end

    context 'when user failed the test twice a while ago' do
      before do
        two_old_failed_test_attempts
      end

      it 'assigns the time until user can take the test' do
        expect(user_programme_asessment.can_take_test_at).to eq (0)
      end

      it 'assigns the number of attempts at test correctly' do
        expect(user_programme_asessment.num_attempts).to eq (2)
      end
    end

    context 'when assessment has been completed' do
      before do
        exam_programme_activity
        passed_exam
      end

      it 'doesn\'t set the time until user can take the test' do
        expect(user_programme_asessment.can_take_test_at).to eq (0)
      end
    end
  end
end
