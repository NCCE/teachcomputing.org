require 'rails_helper'

RSpec.describe Programmes::PrimaryCertificate do
  let(:programme) { create(:primary_certificate) }
  let(:user) { create(:user) }
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

  describe 'user_completed?' do
    before do
      user_programme_enrolment
    end

    context 'when user is not passed in' do
      it 'raises error if user is nil' do
        expect {
          programme.user_completed?(nil)
        }.to raise_error(NoMethodError)
      end
    end

    context 'when user has not done any activities' do
      it 'returns false' do
        expect(programme.user_completed?(user)).to eq false
      end
    end

    context 'when user has partly completed programme' do
      before do
        setup_achievements_for_partial_completion
      end

      it 'returns false' do
        expect(programme.user_completed?(user)).to eq false
      end
    end

    context 'when user has completed programme' do
      before do
        setup_achievements_for_completion
      end

      it 'returns true' do
        expect(programme.user_completed?(user)).to eq true
      end
    end
  end
end
