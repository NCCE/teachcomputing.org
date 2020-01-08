require 'rails_helper'

RSpec.describe Programmes::CSAccelerator do
  let(:programme) { create(:cs_accelerator) }
  let(:diagnostic) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam )}
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  let(:online_courses) { create_list(:activity, 2, :future_learn, credit: 20) }
  let(:face_to_face_courses) { create_list(:activity, 2, :stem_learning, credit: 20) }

  let(:setup_partially_complete_certificate) do
    user_programme_enrolment
    activities = [].concat(online_courses, face_to_face_courses)

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      if activity.category == 'online'
        achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
        achievement.set_to_complete
      end
    end
  end

  let(:setup_complete_certificate) do
    user_programme_enrolment

    activities = [].concat(online_courses, face_to_face_courses)

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
      achievement.set_to_complete
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
        expect {
          programme.diagnostic
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#credits_achieved_for_certificate' do
    context 'when the user has not done any activities' do
      it 'returns 0' do
        expect(programme.credits_achieved_for_certificate(user)).to eq 0
      end
    end

    context 'when the user has done 2 online activities' do
      before do
        setup_partially_complete_certificate
      end

      it 'returns 40' do
        expect(programme.credits_achieved_for_certificate(user)).to eq 40
      end
    end

    context 'when the user has done 2 online & 2 face-to-face activities' do
      before do
        setup_complete_certificate
      end

      it 'returns 80' do
        expect(programme.credits_achieved_for_certificate(user)).to eq 80
      end
    end
  end

  describe '#max_credits_for_certificate' do
    it 'returns 80' do
      expect(programme.max_credits_for_certificate).to eq 80
    end
  end
end
