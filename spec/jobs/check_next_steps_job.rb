require 'rails_helper'

RSpec.describe CheckNextStepsJob, type: :job do
  let!(:user) { create(:user) }
  let!(:activity) { create(:activity) }
  let!(:achievement) { create(:achievement, user_id: user.id) }
  let!(:achievement_2) { create(:achievement, user_id: user.id, activity_id: activity.id) }

  describe '#perform' do
    it 'sends online course completion emails' do
      expect { described_class.perform_now(achievement.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends face to face course completion emails' do
      expect { described_class.perform_now(achievement_2.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
