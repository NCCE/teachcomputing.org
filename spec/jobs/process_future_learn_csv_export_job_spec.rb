require 'rails_helper'

RSpec.describe ProcessFutureLearnCsvExportJob, type: :job do
  let(:activity) { create(:activity, future_learn_id: '1234') }
  let(:user_one) { create(:user, email: 'user1@example.com') }
  let(:user_two) { create(:user, email: 'user2@example.com') }
  let(:user_three) { create(:user, email: 'user3@example.com') }
  let(:user_four) { create(:user, email: 'user4@example.com') }
  let(:user_five) { create(:user, email: 'user5@example.com') }
  let(:commenced_achievement_one) { create(:achievement, user_id: user_four.id, activity_id: activity.id) }
  let(:commenced_achievement_two) { create(:achievement, user_id: user_five.id, activity_id: activity.id) }
  let(:import) { create(:import) }
  let(:csv_contents) do
    'run_start_date,membership_id,learner_identifier,full_name,fl_profile_url,steps_completed,comments_posted,avg_test_score,left_at,course_uuid,
    2019-01-07,1,user1@example.com,Name 1,https://www.futurelearn.com/profiles/1,61%,1,0%,nil,1234,
    2019-01-07,2,user2@example.com,Name 2,https://www.futurelearn.com/profiles/2,0%,0,0%,nil,1234,
    2019-01-07,3,user500@example.com,Name 500,https://www.futurelearn.com/profiles/500,99%,0,0%,nil,1234,
    2019-01-07,4,user4@example.com,Name 4,https://www.futurelearn.com/profiles/4,99%,0,0%,nil,1234,
    2019-01-07,5,user5@example.com,Name 5,https://www.futurelearn.com/profiles/5,59%,0,0%,nil,1234,'
  end

  describe '#perform' do
    before do
      [user_one, user_two, user_three, user_four, user_five, activity]
      ProcessFutureLearnCsvExportJob.perform_now(csv_contents, import)
    end

    context 'when a user exists and steps completed is >= 60%' do
      it 'creates an achievement' do
        expect(user_one.achievements.where(activity_id: activity.id).exists?).to eq true
      end

      it 'creates an achievement with the state of complete' do
        expect(user_one.achievements.find_by(activity_id: activity.id).current_state).to eq 'complete'
      end
    end

    it 'does not create an achievement if a user cannot be found' do
      expect(user_three.achievements.where(activity_id: activity.id).exists?).to eq false
    end

    context 'when steps completed is less than 60' do
      it 'creates an achievement' do
        expect(user_two.achievements.where(activity_id: activity.id).exists?).to eq true
      end

      it 'creates an achievement with the state of complete' do
        expect(user_two.achievements.find_by(activity_id: activity.id).current_state).to eq 'commenced'
      end
    end

    it 'updates the the import record to have a completed_at timestamp' do
      import.reload
      expect(import.completed_at).not_to be_nil
    end

    context 'when an achievement already exits' do
      it 'sets the state to complete if it is >= 60' do
        expect(user_four.achievements.find_by(activity_id: activity.id).current_state).to eq 'complete'
      end

      it 'state remains commenced if steps complete is less than 60' do
        expect(user_five.achievements.find_by(activity_id: activity.id).current_state).to eq 'commenced'
      end
    end
  end
end
