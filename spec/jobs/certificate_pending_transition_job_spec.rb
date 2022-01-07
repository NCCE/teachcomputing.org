require 'rails_helper'

RSpec.describe CertificatePendingTransitionJob, type: :job do
  let(:primary_certificate) { create(:primary_certificate) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme_id: primary_certificate.id, user_id: user.id) }

  describe '#perform' do
    include ActiveJob::TestHelper
    context 'when user is invalid' do
      it 'raises error if user is not found' do
        expect do
          described_class.perform_now(primary_certificate, '123', some_value: '10')
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user is valid and enrolled' do
      before do
        allow_any_instance_of(Programmes::PrimaryCertificate).to receive(:user_meets_completion_requirement?).and_return(true)
        user_programme_enrolment
        described_class.perform_now(primary_certificate, user.id, some_value: '10')
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

      it 'queues ScheduleCertificateCompletionJob job' do
        expect(ScheduleCertificateCompletionJob).to have_been_enqueued.exactly(:once).at(a_value_within(1.minute).of(7.days.from_now))
      end
    end
  end
end
