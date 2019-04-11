require 'rails_helper'

RSpec.describe FetchUsersCompletedCoursesFromAchieverJob, type: :job do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, course_id: 'a6b10502-6788-4ebc-b465-41eafb1e2a18') }

  before do
    stub_delegate_course_list
  end

  describe '#perform' do
    context 'when a matching activity exists' do
      before do
        user
        activity
        FetchUsersCompletedCoursesFromAchieverJob.perform_now(user)
      end

      it 'creates an achievement that belongs to the right activity' do
        expect(Achievement.where(activity_id: activity.id).exists?).to eq true
      end

      it 'creates an achievement that belongs to the right user' do
        expect(Achievement.where(activity_id: activity.id, user_id: user.id).exists?).to eq true
      end
    end

    context 'when an activity cannot be found' do
      it 'does not create an achievement' do
        FetchUsersCompletedCoursesFromAchieverJob.perform_now(user)
        expect(user.achievements.where(activity_id: activity.id).exists?).to eq false
      end
    end
  end
end
