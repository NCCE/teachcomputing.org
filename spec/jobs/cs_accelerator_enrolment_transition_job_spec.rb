require 'rails_helper'

RSpec.describe CsAcceleratorEnrolmentTransitionJob, type: :job do
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id) }

  describe '#perform' do
    before do
      user_programme_enrolment
      CsAcceleratorEnrolmentTransitionJob.perform_now(user, certificate_number: '10')
    end

    it 'transitions to failed' do
      expect(user_programme_enrolment.current_state).to eq 'complete'
    end

    it 'contains the certificate number meta' do
      expect(user_programme_enrolment.last_transition.metadata['certificate_number']).to eq '10'
    end
  end
end
