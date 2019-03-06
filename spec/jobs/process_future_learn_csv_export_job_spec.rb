require 'rails_helper'

RSpec.describe ProcessFutureLearnCsvExportJob, type: :job do
  let(:activity) { create(:activity) }
  let(:user_one) { create(:user, email: 'user1@example.com') }
  let(:user_two) { create(:user, email: 'user2@example.com') }
  let(:user_three) { create(:user, email: 'user3@example.com') }
  let(:import) { create(:import, activity: activity) }
  let(:csv_contents) { 'run_start_date,membership_id,learner_identifier,full_name,fl_profile_url,steps_completed,comments_posted,avg_test_score,left_at
    2019-01-07,1,user1@example.com,Name 1,https://www.futurelearn.com/profiles/1,61%,1,0%,2019-01-07,2,user2@example.com,Name 2,https://www.futurelearn.com/profiles/2,0%,0,0%,
    2019-01-07,3,user999@example.com,Name 3,https://www.futurelearn.com/profiles/3,99%,0,0%,' }

  describe '#perform' do
    before do
      user_one
      user_two
      user_three
      ProcessFutureLearnCsvExportJob.perform_now(activity, csv_contents, import)
    end

    it 'creates an achievement if a user is found and the steps completed is > 60' do
      expect(user_one.achievements.count).to eq 1
    end

    it 'does not create an achievement if a user cannot be found' do
      expect(Achievement.where(user_id: user_three.id).count).to eq 0
    end

    it 'does not create an achievement if steps completed is < 60' do
      expect(user_two.achievements.count).to eq 0
    end

    it 'updates the the import record to have a completed_at timestamp' do
      import.reload
      expect(import.completed_at).not_to be_nil
    end
  end
end
