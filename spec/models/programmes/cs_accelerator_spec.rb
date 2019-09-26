require 'rails_helper'

RSpec.describe Programmes::CSAccelerator do
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam )}
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  describe 'user_completed?' do
    before do
      programme_activity
      user_programme_enrolment
    end

    context 'when user is not passed in' do
      it 'raises error if user is nil' do
        expect {
          Programmes::CSAccelerator.user_completed?(nil, nil)
        }.to raise_error(NoMethodError)
      end
    end

    context 'when programme is not passed in' do
      it 'raises error if programme is nil' do
        expect {
          Programmes::CSAccelerator.user_completed?(user, nil)
        }.to raise_error(NoMethodError)
      end
    end

    context 'when user has not completed programme' do
      it 'returns false' do
        expect(Programmes::CSAccelerator.user_completed?(user, programme)).to eq false
      end
    end

    context 'when user has completed programme' do
      before do
        passed_exam
      end

      it 'returns true' do
        expect(Programmes::CSAccelerator.user_completed?(user, programme)).to eq true
      end
    end
  end
end
