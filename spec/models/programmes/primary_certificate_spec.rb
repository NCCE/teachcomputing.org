require 'rails_helper'

RSpec.describe Programmes::PrimaryCertificate do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:diagnostic) { create(:activity, :primary_certificate_diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic.id) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:online_course) { create(:activity, :future_learn, credit: 20) }
  let(:face_to_face_course) { create(:activity, :stem_learning, credit: 20) }
  let(:community_10_activity) { create(:activity, :community) }
  let(:community_5_activity) { create(:activity, :community_5) }
  let(:community_20_activity) { create(:activity, :community_20) }


  let(:setup_achievements_for_partial_completion) do
    user_programme_enrolment
    activities = [online_course, face_to_face_course, community_5_activity]

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      create(:completed_achievement, user_id: user.id, activity_id: activity.id)
    end
  end

  let(:setup_achievements_for_completion) do
    user_programme_enrolment
    activities = [online_course, face_to_face_course, community_5_activity, community_10_activity, community_20_activity]

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      create(:completed_achievement, user_id: user.id, activity_id: activity.id)
    end
  end

  let(:setup_diagnostic_score) do
    user_programme_enrolment
    create(:programme_activity, programme_id: programme.id, activity_id: diagnostic.id)
    diagnostic_achievement
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

  describe '#diagnostic_result' do
    before do
      user_programme_enrolment
    end

    context 'when user has not done the diagnostic' do
      it 'raises error if called' do
        expect {
          programme.diagnostic_result(user)
        }.to raise_error(NoMethodError)
      end
    end

    context 'when user has done the diagnostic with a score of 15' do
      before do
        setup_diagnostic_score
        diagnostic_achievement.transition_to(:complete, score: 15)
      end

      it 'returns correct score' do
        expect(programme.diagnostic_result(user)).to eq(15)
      end
    end
  end

  describe '#user_meets_completion_requirement?' do
    before do
      user_programme_enrolment
    end

    context 'when user is not passed in' do
      it 'raises error if user is nil' do
        expect {
          programme.user_meets_completion_requirement?(nil)
        }.to raise_error(NoMethodError)
      end
    end

    context 'when user has not done any activities' do
      it 'returns false' do
        expect(programme.user_meets_completion_requirement?(user)).to eq false
      end
    end

    context 'when user has partly completed programme' do
      before do
        setup_achievements_for_partial_completion
      end

      it 'returns false' do
        expect(programme.user_meets_completion_requirement?(user)).to eq false
      end
    end

    context 'when user has completed programme' do
      before do
        setup_achievements_for_completion
      end

      it 'returns true' do
        expect(programme.user_meets_completion_requirement?(user)).to eq true
      end
    end
  end
end
