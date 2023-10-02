require 'rails_helper'

RSpec.describe CertificatePendingTransitionJob, type: :job do
  let!(:primary_certificate) { create(:primary_certificate) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme_id: primary_certificate.id, user_id: user.id) }

  describe '#perform' do
    include ActiveJob::TestHelper

    context 'when user is valid but not enrolled' do
      before do
        primary_certificate
      end

      it "doesn't cause errors" do
        expect do
          described_class.perform_now(user, { some_value: '10' })
        end.not_to raise_error
      end
    end

    context 'when user is valid and enrolled' do
      before do
        allow_any_instance_of(Programmes::PrimaryCertificate).to receive(:user_meets_completion_requirement?).and_return(true)
        user_programme_enrolment
        described_class.perform_now(user, { some_value: '10' })
      end

      after do
        clear_enqueued_jobs
      end

      it 'transitions to pending' do
        expect(user_programme_enrolment.current_state).to eq 'pending'
      end

      it 'metadata is stored' do
        expect(user_programme_enrolment.last_transition.metadata['some_value']).to eq '10'
      end
    end
  end
end
