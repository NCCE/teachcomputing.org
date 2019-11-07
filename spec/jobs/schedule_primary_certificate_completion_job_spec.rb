require 'rails_helper'

RSpec.describe SchedulePrimaryCertificateCompletionJob, type: :job do
  let(:enrolment) { create(:user_programme_enrolment) }
  let(:programme_complete_counter) { create(:programme_complete_counter, programme_id: enrolment.programme.id)}

  describe '#perform' do
    before do
      enrolment
      programme_complete_counter
      SchedulePrimaryCertificateCompletionJob.perform_now(enrolment)
    end

    it 'transitions it to complete' do
      expect(enrolment.current_state).to eq 'complete'
    end

    it 'the transition has the certificate number meta' do
      expect(enrolment.last_transition.metadata['certificate_number']).to eq 1
    end
  end
end
