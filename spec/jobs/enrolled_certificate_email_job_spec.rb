require 'rails_helper'

RSpec.describe EnrolledCertificateEmailJob, type: :job do
  let(:primary) { create(:primary_certificate) }
  let(:primary_enrolment) { create(:user_programme_enrolment, programme_id: primary.id) }

  describe '#perform' do
    context 'when the programme is primary' do
      it 'sends an email' do
        expect { described_class.perform_now(primary_enrolment.user, primary_enrolment.programme) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
