require 'rails_helper'

RSpec.describe CompleteCertificateEmailJob, type: :job do
  let(:enrolment) { create(:user_programme_enrolment) }

  describe '#perform' do
    it 'sends an email' do
      expect { described_class.perform_now(enrolment.user, enrolment.programme) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
