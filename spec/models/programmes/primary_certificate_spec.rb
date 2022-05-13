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
    activities = [online_course, face_to_face_course, community_5_activity, community_10_activity,
                  community_20_activity]

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      create(:completed_achievement, user_id: user.id, activity_id: activity.id)
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

  describe '#path' do
    it 'returns the path for the programme' do
      expect(programme.path).to eq('/certificate/primary-certificate')
    end
  end

  describe '#enrol_path' do
    it 'returns the path for the enrol' do
      expect(programme.enrol_path(user_programme_enrolment: { user_id: 'user_id',
                                                              programme_id: 'programme_id' })).to eq('/certificate/primary-certificate/enrol?user_programme_enrolment%5Bprogramme_id%5D=programme_id&user_programme_enrolment%5Buser_id%5D=user_id')
    end
  end

  describe '#programme_title' do
    it 'returns correct title' do
      expect(programme.programme_title)
        .to eq('Primary Computing Teaching')
    end
  end
end
