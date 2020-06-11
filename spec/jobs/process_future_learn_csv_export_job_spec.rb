require 'rails_helper'

RSpec.describe ProcessFutureLearnCsvExportJob, type: :job do
  let(:activity_one) { create(:activity, future_learn_course_uuid: '1234') }
  let(:activity_two) { create(:activity, future_learn_course_uuid: '5678') }
  let(:activity_three) { create(:activity, future_learn_course_uuid: '2222') }
  let(:activity_four) { create(:activity, future_learn_course_uuid: '3333') }
  let!(:user_one) { create(:user, email: 'user1@example.com') }
  let!(:user_two) { create(:user, email: 'user2@example.com') }
  let!(:user_three) { create(:user, email: 'user3@example.com') }
  let!(:user_four) { create(:user, email: 'user4@example.com') }
  let!(:user_five) { create(:user, email: 'user5@example.com') }
  let!(:user_six) { create(:user, email: 'user6@example.com') }
  let(:dropped_achievement) { create(:achievement, user_id: user_six.id, activity_id: activity_two.id) }
  let(:another_dropped_achievement) { create(:achievement, user_id: user_two.id, activity_id: activity_two.id) }
  let(:completed_achievement) { create(:achievement, user_id: user_four.id, activity_id: activity_two.id) }
  let(:import) { create(:import) }
  let(:csv_contents) { File.read('spec/support/test_future_learn_export.csv') }
  let(:programme) { create(:primary_certificate) }

  let(:cs_acc_programme) { create(:cs_accelerator) }

  describe '#perform' do
    include ActiveJob::TestHelper

    before do
      create(:programme_activity, programme_id: programme.id, activity_id: activity_one.id)
      create(:programme_activity, programme_id: cs_acc_programme.id, activity_id: activity_three.id)
      create(:programme_activity, programme_id: cs_acc_programme.id, activity_id: activity_four.id)
      dropped_achievement.transition_to(:dropped)
      another_dropped_achievement.transition_to(:dropped)
      completed_achievement.transition_to(:complete)
      allow(Raven).to receive(:capture_exception)
      described_class.perform_now(csv_contents, import)
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
      expect(Raven).to have_received(:capture_exception).with(/91011/)
    end

    it 'only sends one message to Raven for 2 rows with the same missing course' do
      expect(Raven).to have_received(:capture_exception).once
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
        expect(
          user_two.achievements
          .find_by(activity_id: activity_two.id)
          .last_transition.metadata['progress']
        ).to eq 45.0
        expect(
          user_one.achievements
          .find_by(activity_id: activity_two.id)
          .last_transition.metadata['progress']
        ).to eq 15.0
      end

      it 'state remains enrolled if steps complete is 0' do
        expect(user_five.achievements.find_by(activity_id: activity_one.id).current_state).to eq 'enrolled'
      end
    end

    it 'queues PrimaryCertificatePendingTransitionJob job for complete courses' do
      expect(PrimaryCertificatePendingTransitionJob).to have_been_enqueued.exactly(:once)
    end

    it 'queues AssessmentEligibilityJob once for cs-accelerator per user' do
      expect(AssessmentEligibilityJob).to have_been_enqueued.exactly(:once)
    end
  end
end
