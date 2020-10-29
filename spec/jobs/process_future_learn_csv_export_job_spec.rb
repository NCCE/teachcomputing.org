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
  let!(:membership_id_user) { create(:user, email: 'user7@example.com', future_learn_organisation_memberships: ['7d116df9-7001-4e49-885c-98fd311f09e3']) }
  let!(:no_membership_id_user) { create(:user, email: 'user8@example.com') }
  let!(:wrong_membership_id_user) { create(:user, email: 'user9@example.com', future_learn_organisation_memberships: ['9d1c1daa-7f99-40d8-88cb-d567e97d1fce']) }
  let!(:id_user) { create(:user, id: '83b9d231-ed72-47d1-87ad-d985f4182ff1') }
  let!(:double_membership_id_user) { create(:user, id: '53a92624-d785-4f23-860d-77d35c9a9c2e', email: 'user10@example.com', future_learn_organisation_memberships: ['bdea158d-a6bf-4f79-886b-611e861c3acf']) }

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

    it 'handles export correctly' do
      # when a user exists and steps completed is >= 60% it creates an achievement
      expect(user_one.achievements.where(activity_id: activity_one.id).exists?).to eq true

      # it creates an achievement with the state of complete
      expect(user_one.achievements.find_by(activity_id: activity_one.id).current_state).to eq 'complete'

      # it does not create an achievement if a user cannot be found
      expect(user_three.achievements.where(activity_id: activity_one.id).exists?).to eq false

      # it does not create an achievement if an activity cannot be found
      expect(user_one.achievements.where(activity_id: '91011').exists?).to eq false

      # it sends a message to Raven if an activity cannot be found
      expect(Raven).to have_received(:capture_exception).with(/91011/)

      # it only sends one message to Raven for 2 rows with the same missing course
      expect(Raven).to have_received(:capture_exception).once

      # when steps completed is less than 60 it creates an achievement
      expect(user_two.achievements.where(activity_id: activity_one.id).exists?).to eq true

      # it creates an achievement with the state of enrolled
      expect(user_two.achievements.find_by(activity_id: activity_one.id).current_state).to eq 'enrolled'

      # it updates the the import record to have a completed_at timestamp
      expect(import.reload.completed_at).not_to be_nil

      # when left_at is present it transitions the state to dropped
      expect(user_six.achievements.find_by(activity_id: activity_one.id).current_state).to eq 'dropped'

      # it does not transition it to dropped if it is already complete
      expect(user_four.achievements.find_by(activity_id: activity_one.id).current_state).to eq 'complete'

      # it does not transition to dropped if progress is 60%+
      expect(user_four.achievements.find_by(activity_id: activity_two.id).current_state).to eq 'complete'

      # when an achievement is in a state of dropped it transitions to enrolled
      expect(user_six.achievements.find_by(activity_id: activity_two.id).current_state).to eq 'enrolled'

      # when an achievement already exits it sets the state to complete if it is >= 60
      expect(user_four.achievements.find_by(activity_id: activity_two.id).current_state).to eq 'complete'

      # it state transitions to in_progress if steps complete is between 1 and 59
      expect(user_one.achievements.find_by(activity_id: activity_two.id).current_state).to eq 'in_progress'

      # it state in_progress shows correct metadata
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

      # it state remains enrolled if steps complete is 0
      expect(user_five.achievements.find_by(activity_id: activity_one.id).current_state).to eq 'enrolled'

      # when learner_identifier is user id it creates an achievement
      expect(id_user.achievements.where(activity_id: activity_one.id).exists?).to eq true

      # when user membership_id is set it "doesn't change user membership_id"
      expect(membership_id_user.reload.future_learn_organisation_memberships)
        .to eq(['7d116df9-7001-4e49-885c-98fd311f09e3'])

      # when user membership_id is set but user has second organisation membership it adds second membership id
      expect(double_membership_id_user.reload.future_learn_organisation_memberships)
        .to match_array(%w[bdea158d-a6bf-4f79-886b-611e861c3acf b0af88ab-d62f-407d-a58f-bb7998827a49])

      # when user membership_id is not set it sets user membership_id
      expect(no_membership_id_user.reload.future_learn_organisation_memberships)
        .to eq(['22752662-3f65-4c54-a394-0284679cccb9'])

      # when user membership_id is different from the export value it logs an error
      expect(Raven)
        .to have_received(:capture_exception)
        .once
        .with('Missing course : id 91011 (user is: user1@example.com)')

      # it queues PrimaryCertificatePendingTransitionJob job for complete courses'
      expect(PrimaryCertificatePendingTransitionJob).to have_been_enqueued.exactly(7).times

      # it queues AssessmentEligibilityJob once for cs-accelerator per user
      expect(AssessmentEligibilityJob).to have_been_enqueued.exactly(:once)
    end
  end
end
