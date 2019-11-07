require 'rails_helper'

RSpec.describe PrimaryCertificatePendingTransitionJob, type: :job do
  let(:primary_certificate) { create(:primary_certificate) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme_id: primary_certificate.id, user_id: user.id) }

  describe '#perform' do
    include ActiveJob::TestHelper
    context 'when user is invalid' do
      it 'raises error if user is not found' do
        expect {
          PrimaryCertificatePendingTransitionJob.perform_now('123', some_value: '10')
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user is valid but mot enrolled' do
      before do
        primary_certificate
      end

      it 'doesn\'t cause errors' do
        expect {
          PrimaryCertificatePendingTransitionJob.perform_now(user.id, some_value: '10')
        }.not_to raise_error
      end
    end

    context 'when user is valid and enrolled' do
      before do
        allow_any_instance_of(Programmes::PrimaryCertificate).to receive(:user_meets_completion_requirement?).and_return(true)
        user_programme_enrolment
        PrimaryCertificatePendingTransitionJob.perform_now(user.id, some_value: '10')
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

      it 'queues SchedulePrimaryCertificateCompletionJob job' do
        expect(SchedulePrimaryCertificateCompletionJob).to have_been_enqueued.exactly(:once).at(7.days)
      end
    end
  end
end
