require 'rails_helper'

RSpec.describe StateMachines::UserProgrammeEnrolmentStateMachine do
  let(:user_programme_enrolment) { create(:user_programme_enrolment) }

  describe 'initial state' do
    it 'returns enrolled' do
      expect(described_class.initial_state).to eq 'enrolled'
    end
  end

  describe 'after_transition hooks' do
    it 'queues CompleteCertificateEmailJob job' do
      expect do
        user_programme_enrolment.transition_to(:complete)
      end.to have_enqueued_job(CompleteCertificateEmailJob)
    end
  end
end
