require 'rails_helper'

RSpec.describe StateMachines::UserProgrammeEnrolmentStateMachine do
  let(:user_programme_enrolment) { create(:user_programme_enrolment) }

  describe 'initial state' do
    it 'returns enrolled' do
      expect(described_class.initial_state).to eq 'enrolled'
    end
  end

  describe 'guards' do
    before do
      user_programme_enrolment
    end

    it 'can transition to complete when not flagged' do
      expect(user_programme_enrolment.transition_to(:complete)).to eq true
    end

    it 'cannot transition to complete if flagged' do
      user_programme_enrolment.update(flagged: true)
      expect(user_programme_enrolment.transition_to(:complete)).to eq false
    end
  end

  describe 'after_transition hooks' do
    it 'queues CompleteCertificateEmailJob job' do
      expect do
        user_programme_enrolment.transition_to(:complete)
      end.to have_enqueued_job(CompleteCertificateEmailJob)
    end

    it 'queues a Pending email for I Belong certificate' do
      user = create(:user)
      user_programme_enrolment = create(:user_programme_enrolment, programme: create(:i_belong), user:)
      expect do
        user_programme_enrolment.transition_to(:pending)
      end.to have_enqueued_mail(IBelongMailer, :pending)
    end
  end
end
