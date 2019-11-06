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

  let(:online_recommendation) { 'Programming 101: An Introduction to Python for Educators' }
  let(:face_to_face_recommendation) { 'Teaching and leading key stage 1 computing' }

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

  describe '#course_recommendations' do
    before do
      user_programme_enrolment
    end

    context 'when user has not done the diagnostic' do
      it 'raises error if called' do
        expect {
          programme.course_recommendations(user)
        }.to raise_error(NoMethodError)
      end
    end

    context 'when user has done the diagnostic with a score of 15' do
      before do
        setup_diagnostic_score
        diagnostic_achievement.transition_to(:complete, score: 15)
      end

      it 'recommendation has correct fields' do
        recommendation = programme.course_recommendations(user, Activity::ONLINE_CATEGORY).first
        expect(recommendation).to have_key(:link)
        expect(recommendation).to have_key(:link)
        expect(recommendation).to have_key(:description)
      end

      it 'returns a matching recommendation for an online course' do
        recommendation = programme.course_recommendations(user, Activity::ONLINE_CATEGORY).first
        expect(recommendation[:title]).to eq(online_recommendation)
      end

      it 'returns a matching recommendation for a face-to-face course' do
        recommendation = programme.course_recommendations(user, Activity::FACE_TO_FACE_CATEGORY).first
        expect(recommendation[:title]).to eq(face_to_face_recommendation)
      end
    end

    context 'when user has done the diagnostic with a score in a different range' do
      before do
        setup_diagnostic_score
        diagnostic_achievement.transition_to(:complete, score: 21)
      end

      it 'returns a different recommendation for an online course' do
        recommendation = programme.course_recommendations(user, Activity::ONLINE_CATEGORY).first
        expect(recommendation[:title]).not_to eq(online_recommendation)
      end

      it 'returns a different recommendation for a face-to-face course' do
        recommendation = programme.course_recommendations(user, Activity::FACE_TO_FACE_CATEGORY).first
        expect(recommendation[:title]).not_to eq(face_to_face_recommendation)
      end
    end
  end
end
