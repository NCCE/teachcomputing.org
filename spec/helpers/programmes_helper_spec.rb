require 'rails_helper'

describe ProgrammesHelper, type: :helper do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme_id: programme.id, user_id: user.id) }
  let(:diagnostic_tool_activity) { create(:activity, :diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }
  let(:online_courses) { create_list(:activity, 2, :future_learn, credit: 20) }
  let(:face_to_face_courses) { create_list(:activity, 2, :stem_learning, credit: 20) }

  describe('#can_take_accelerator_test?') do
    it 'throws exception without the user' do
      expect {
        helper.can_take_accelerator_test?(nil, nil)
      }.to raise_error(NoMethodError)
    end

    it 'throws exception without the programme' do
      expect {
        helper.can_take_accelerator_test?(user, nil)
      }.to raise_error(NoMethodError)
    end

    it 'returns false when user is not enrolled' do
      expect(helper.can_take_accelerator_test?(user, programme)).to eq false
    end

    context 'when user hasn\'t done enough activities' do
      before do
        user_programme_enrolment

        activities = [diagnostic_tool_activity].concat(online_courses, face_to_face_courses)

        activities.each do |activity|
          create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
        end
        diagnostic_achievement
      end

      it 'returns false' do
        expect(helper.can_take_accelerator_test?(user, programme)).to eq false
      end
    end

    context 'when user has done enough activities' do
      it 'returns true' do
        user_programme_enrolment

        activities = [diagnostic_tool_activity].concat(online_courses, face_to_face_courses)

        activities.each do |activity|
          create(:programme_activity, programme_id: programme.id, activity_id: activity.id)
          achievement = create(:achievement, user_id: user.id, activity_id: activity.id)
          achievement.set_to_complete
        end
        expect(helper.can_take_accelerator_test?(user, programme)).to eq true
      end
    end
  end
end
