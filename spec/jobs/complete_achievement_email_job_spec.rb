require 'rails_helper'

RSpec.describe CompleteAchievementEmailJob, type: :job do
  let(:user) { create(:user, email: 'john@example.com') }
  let(:activity) { create(:activity) }

  describe '#perform' do
    it 'sends an email' do
      pending("Pending email content")
      expect { described_class.perform_now(user.id, activity.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
