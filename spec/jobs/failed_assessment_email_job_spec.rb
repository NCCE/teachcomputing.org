require 'rails_helper'

RSpec.describe FailedAssessmentEmailJob, type: :job do
  let(:user) { create(:user, email: 'john@example.com') }

  describe '#perform' do
    it 'sends an email' do
      expect { described_class.perform_now(user.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
