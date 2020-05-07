require 'rails_helper'

RSpec.describe NonEnrolledCSAUserEmailJob, type: :job do
  let(:user) { create(:user, email: 'john@example.com') }
  let(:programme) { create(:cs_accelerator) }

  describe '#perform' do
    it 'sends an email' do
      programme
      expect { described_class.perform_now(user.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
