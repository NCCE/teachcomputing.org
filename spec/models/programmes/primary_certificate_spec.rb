require 'rails_helper'

RSpec.describe Programmes::PrimaryCertificate do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
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
    create(:primary_enrolment_score_15, programme: programme, user: user)
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

  describe '#credits_achieved_for_certificate' do
    context 'when the user has not done any activities' do
      it 'returns 0' do
        expect(programme.credits_achieved_for_certificate(user)).to eq 0
      end
    end

    context 'when the user has done 2 online activities' do
      before do
        setup_achievements_for_partial_completion
      end

      it 'returns 45' do
        expect(programme.credits_achieved_for_certificate(user)).to eq 45
      end
    end

    context 'when the user has done enough activities' do
      before do
        setup_achievements_for_completion
      end

      it 'returns 75' do
        expect(programme.credits_achieved_for_certificate(user)).to eq 75
      end
    end
  end

  describe '#max_credits_for_certificate' do
    it 'returns 75' do
      expect(programme.max_credits_for_certificate).to eq 75
    end
  end
end
