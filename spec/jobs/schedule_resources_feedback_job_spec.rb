require 'rails_helper'

RSpec.describe ScheduleUserResourcesFeedbackJob, type: :job do
  let(:user) { create(:user) }

  describe '#perform' do
    it 'sends an email' do
      expect { ScheduleUserResourcesFeedbackJob.perform_now(user, 1) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
