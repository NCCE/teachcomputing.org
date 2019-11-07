require 'rails_helper'

RSpec.describe FetchUsersCompletedCoursesFromAchieverJob, type: :job do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:activity_one) { create(:activity, stem_course_id: '92f4f86e-0237-4ecc-a905-2f6c62d6b5ae') }
  let(:activity_two) { create(:activity, stem_course_id: '92f4f86e-0237-4ecc-a905-2f6c62d6b5ax') }
  let(:activity_three) { create(:activity, stem_course_id: '92f4f86e-0237-4ecc-a905-2f6c62d6b5aw') }
  let(:achievement) { create(:achievement, activity_id: activity_three.id, user_id: user.id) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: activity_one.id) }

  before do
    stub_delegate
  end

  describe '#perform' do
    include ActiveJob::TestHelper
    context 'when a matching activity exists' do
      before do
        [user, activity_one, activity_two, activity_three, achievement, programme_activity]
        FetchUsersCompletedCoursesFromAchieverJob.perform_now(user)
      end

      after do
        clear_enqueued_jobs
      end

      it 'creates an achievement that belongs to the right activity' do
        expect(Achievement.where(activity_id: activity_one.id).exists?).to eq true
      end

      it 'creates an achievement that belongs to the right user' do
        expect(Achievement.where(activity_id: activity_one.id, user_id: user.id).exists?).to eq true
      end

      it 'sets the correct complete state when the course is fully attended' do
        achievement = Achievement.where(activity_id: activity_one.id, user_id: user.id).first
        expect(achievement.current_state).to eq 'complete'
      end

      it 'has the state of commenced when the course is not fully attended' do
        achievement = Achievement.where(activity_id: activity_two.id, user_id: user.id).first
        expect(achievement.current_state).to eq 'commenced'
      end

      context 'when an an achievement already exits' do
        it 'sets the state to complete if it is fully attended' do
          expect(achievement.current_state).to eq 'complete'
        end
      end

      it 'queues PrimaryCertificatePendingTransitionJob job for complete courses' do
        expect(PrimaryCertificatePendingTransitionJob).to have_been_enqueued.exactly(:once)
      end
    end

    context 'when an activity cannot be found' do
      it 'does not create an achievement' do
        FetchUsersCompletedCoursesFromAchieverJob.perform_now(user)
        expect(user.achievements.where(activity_id: activity_one.id).exists?).to eq false
      end
    end
  end
end
