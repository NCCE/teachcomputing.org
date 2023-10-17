require 'rails_helper'

RSpec.describe ScheduleCertificateCompletionJob, type: :job do
  let(:school) { 'Bath School' }
  let(:user) { create(:user, school:) }
  let(:programme) { create(:programme) }
  let(:counter) { 21 }
  let(:programme_complete_counter) { create(:programme_complete_counter, programme:, counter: 21) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }

  describe '#perform' do
    before do
      programme_complete_counter
    end

    it 'should increment programme counter' do
      expect(programme_complete_counter).to receive(:get_next_number)
      described_class.perform_now(user_programme_enrolment)
    end

    it 'should transition UPE to complete' do
      described_class.perform_now(user_programme_enrolment)

      expect(user_programme_enrolment.in_state?(:complete)).to be true
    end

    it 'should set transition certificate number metadata PCC value' do
      described_class.perform_now(user_programme_enrolment)

      expect(user_programme_enrolment.last_transition.metadata['certificate_number']).to eq programme_complete_counter.counter
    end

    context 'when the programme is i_belong' do
      let(:programme) { create(:i_belong) }

      it 'should set users i_belong_certificate_name to user.school' do
        described_class.perform_now(user_programme_enrolment)

        expect(user.i_belong_certificate_name).to eq user.school
      end
    end
  end
end
