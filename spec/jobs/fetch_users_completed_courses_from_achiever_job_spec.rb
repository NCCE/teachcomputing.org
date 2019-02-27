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
        expect(Achievement.first.activity_id).to eq activity.id
      end

      it 'creates an achievement that belongs to the right user' do
        expect(Achievement.first.user_id).to eq user.id
      end
    end
    
    context 'when an activity cannot be found' do
      it 'does not create an achievement' do
        FetchUsersCompletedCoursesFromAchieverJob.perform_now(user)
        expect(Achievement.count).to eq 0
      end
    end
  end
end
