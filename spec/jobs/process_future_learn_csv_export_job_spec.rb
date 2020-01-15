require 'rails_helper'

RSpec.describe ProcessFutureLearnCsvExportJob, type: :job do
  let(:activity_one) { create(:activity, future_learn_course_id: '1234') }
  let(:activity_two) { create(:activity, future_learn_course_id: '5678') }
  let(:user_one) { create(:user, email: 'user1@example.com') }
  let(:user_two) { create(:user, email: 'user2@example.com') }
  let(:user_three) { create(:user, email: 'user3@example.com') }
  let(:user_four) { create(:user, email: 'user4@example.com') }
  let(:user_five) { create(:user, email: 'user5@example.com') }
  let(:user_six) { create(:user, email: 'user6@example.com') }
  let(:dropped_achievement) { create(:achievement, user_id: user_six.id, activity_id: activity_two.id) }
  let(:another_dropped_achievement) { create(:achievement, user_id: user_two.id, activity_id: activity_two.id) }
  let(:completed_achievement) { create(:achievement, user_id: user_four.id, activity_id: activity_two.id) }
  let(:import) { create(:import) }
  let(:csv_contents) do
    'run_start_date,membership_id,learner_identifier,full_name,fl_profile_url,steps_completed,comments_posted,avg_test_score,left_at,course_uuid,
    2019-01-07,1,user1@example.com,Name 1,https://www.futurelearn.com/profiles/1,61%,1,0%,,1234,
    2019-01-07,2,user2@example.com,Name 2,https://www.futurelearn.com/profiles/2,0%,0,0%,,1234,
    2019-01-07,3,user500@example.com,Name 500,https://www.futurelearn.com/profiles/500,99%,0,0%, ,1234,
    2019-01-07,4,user4@example.com,Name 4,https://www.futurelearn.com/profiles/4,99%,0,0%,2019-05-03 10:45:45 UTC,1234,
    2019-01-07,4,user4@example.com,Name 4,https://www.futurelearn.com/profiles/4,99%,0,0%,2019-05-03 10:45:45 UTC,5678,
    2019-01-07,5,user5@example.com,Name 5,https://www.futurelearn.com/profiles/5,0%,0,0%,,1234,
    2019-01-07,6,user6@example.com,Name 6,https://www.futurelearn.com/profiles/6,44%,0,0%,2019-05-03 10:45:45 UTC,1234,
    2019-01-07,6,user6@example.com,Name 6,https://www.futurelearn.com/profiles/6,0%,0,0%,,5678,
    2019-01-07,1,user1@example.com,Name 1,https://www.futurelearn.com/profiles/1,23%,0,0%,,91011,
    2019-01-07,2,user2@example.com,Name 2,https://www.futurelearn.com/profiles/2,23%,0,0%,,91011,
    2019-01-07,1,user1@example.com,Name 1,https://www.futurelearn.com/profiles/1,15%,10,0%,,5678,
    2019-01-07,2,user2@example.com,Name 2,https://www.futurelearn.com/profiles/2,45%,0,0%,,5678,'
  end
  let(:programme) { create(:primary_certificate) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: activity_one.id) }

  describe '#perform' do
    include ActiveJob::TestHelper

    before do
      [user_one, user_two, user_three, user_four, user_five, user_six, activity_one, activity_two, programme_activity]
      dropped_achievement.transition_to(:dropped)
      another_dropped_achievement.transition_to(:dropped)
      completed_achievement.transition_to(:complete)
      allow(Raven).to receive(:capture_message)
      ProcessFutureLearnCsvExportJob.perform_now(csv_contents, import)
    end

    after do
      clear_enqueued_jobs
    end

    context 'when a user exists and steps completed is >= 60%' do
      it 'creates an achievement' do
        expect(user_one.achievements.where(activity_id: activity_one.id).exists?).to eq true
      end

      it 'creates an achievement with the state of complete' do
        expect(user_one.achievements.find_by(activity_id: activity_one.id).current_state).to eq 'complete'
      end
    end

    it 'does not create an achievement if a user cannot be found' do
      expect(user_three.achievements.where(activity_id: activity_one.id).exists?).to eq false
    end

    it 'does not create an achievement if an activity cannot be found' do
      expect(user_one.achievements.where(activity_id: '91011').exists?).to eq false
    end

    it 'sends a message to Raven if an activity cannot be found' do
      expect(Raven).to have_received(:capture_message).with(/91011/)
    end

    it 'only sends one message to Raven for 2 rows with the same missing course' do
      expect(Raven).to have_received(:capture_message).once
    end

    context 'when steps completed is less than 60' do
      it 'creates an achievement' do
        expect(user_two.achievements.where(activity_id: activity_one.id).exists?).to eq true
      end

      it 'creates an achievement with the state of enrolled' do
        expect(user_two.achievements.find_by(activity_id: activity_one.id).current_state).to eq 'enrolled'
      end
    end

    it 'updates the the import record to have a completed_at timestamp' do
      import.reload
      expect(import.completed_at).not_to be_nil
    end

    context 'when left_at is present' do
      it 'transitions the state to dropped' do
        expect(user_six.achievements.find_by(activity_id: activity_one.id).current_state).to eq 'dropped'
      end

      it 'does not transition it to dropped if it is already complete' do
        expect(user_four.achievements.find_by(activity_id: activity_two.id).current_state).to eq 'complete'
      end
    end

    context 'when an achievement is in a state of dropped' do
      it 'transitions to enrolled' do
        expect(user_six.achievements.find_by(activity_id: activity_two.id).current_state).to eq 'enrolled'
      end
    end

    context 'when an achievement already exits' do
      it 'sets the state to complete if it is >= 60' do
        expect(user_four.achievements.find_by(activity_id: activity_two.id).current_state).to eq 'complete'
      end

      it 'state transitions to in_progress if steps complete is between 1 and 59' do
        expect(user_one.achievements.find_by(activity_id: activity_two.id).current_state).to eq 'in_progress'
      end

      it 'state transitions to in_progress if it was dropped' do
        expect(user_two.achievements.find_by(activity_id: activity_two.id).current_state).to eq 'in_progress'
      end

      it 'state in_progress shows correct metadata' do
        expect(user_two.achievements.find_by(activity_id: activity_two.id).last_transition.metadata['progress']).to eq 45.0
        expect(user_one.achievements.find_by(activity_id: activity_two.id).last_transition.metadata['progress']).to eq 15.0
      end

      it 'state remains enrolled if steps complete is 0' do
        expect(user_five.achievements.find_by(activity_id: activity_one.id).current_state).to eq 'enrolled'
      end
    end

    it 'queues PrimaryCertificatePendingTransitionJob job for complete courses' do
      expect(PrimaryCertificatePendingTransitionJob).to have_been_enqueued.exactly(:once)
    end
  end
end
