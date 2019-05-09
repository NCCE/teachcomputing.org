require 'rails_helper'

describe ProgrammesHelper, type: :helper do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id) }
  let(:diagnostic_tool_activity) { create(:activity, :diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }
  let(:online_courses) { create_list(:activity, 2, :future_learn, credit: 20) }
  let(:face_to_face_courses) { create_list(:activity, 2, :stem_learning, credit: 20) }
  
  let(:setup_partially_complete_certificate) do 
    user_programme_enrolment
    activities = [diagnostic_tool_activity].concat(online_courses, face_to_face_courses)

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      if activity.category == 'online'
        achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
        achievement.set_to_complete
      end
    end
    diagnostic_achievement
  end

  let(:setup_complete_certificate) do
    user_programme_enrolment

    activities = [diagnostic_tool_activity].concat(online_courses, face_to_face_courses)

    activities.each do |activity|
      create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
      achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
      achievement.set_to_complete
    end
  end

  describe('#credits_for_accelerator') do
    it 'throws exception without the user' do
      expect {
        helper.credits_for_accelerator(nil, nil)
      }.to raise_error(NoMethodError)
    end

    it 'throws exception without the programme' do
      expect {
        helper.credits_for_accelerator(user, nil)
      }.to raise_error(NoMethodError)
    end

    it 'yields zero when user is not enrolled' do
      expect { |b| helper.credits_for_accelerator(user, programme, &b) }.to yield_with_args(0.0)
    end

    context 'when user hasn\'t done enough activities' do
      before do
        setup_partially_complete_certificate
      end

      it 'returns correct score for credits' do
        expect { |b| helper.credits_for_accelerator(user, programme, &b) }.to yield_with_args(40.0)
      end
    end

    context 'when user has done enough activities' do
      before do
        setup_complete_certificate
      end

      it 'returns true' do
        expect { |b| helper.credits_for_accelerator(user, programme, &b) }.to yield_with_args(80.0)
      end
    end
  end

  describe('#can_take_accelerator_test?') do
    context 'when user hasn\'t done enough activities' do
      before do
        setup_partially_complete_certificate
      end

      it 'returns false' do
        expect(helper.can_take_accelerator_test?(user, programme)).to eq false
      end
    end

    context 'when user has done enough activities' do
      before do
        setup_complete_certificate
      end

      it 'returns true' do
        expect(helper.can_take_accelerator_test?(user, programme)).to eq true
      end
    end
  end
end
