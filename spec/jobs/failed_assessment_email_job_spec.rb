require 'rails_helper'

# To be enabled once email content received

RSpec.describe FailedAssessmentEmailJob, type: :job do
  let(:user) { create(:user, email: 'john@example.com') }

  describe '#perform' do
    it 'sends an email' do
      pending("Pending email content")
      expect { described_class.perform_now(user.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
