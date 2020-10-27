require 'rails_helper'

RSpec.describe Programmes::SecondaryCertificate do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: cs_accelerator.id) }
  let(:secondary_certificate) { create(:secondary_certificate) }

  describe '#user_is_eligible?' do
    context 'when user has not completed cs_accelerator' do
      it 'returns falsey' do
        expect(cs_accelerator_enrolment.current_state).to eq(:enrolled.to_s)
        expect(secondary_certificate.user_is_eligible?(user)).to be_falsey
      end
    end

    context 'when user has completed cs_accelerator' do
      before do
        cs_accelerator_enrolment.transition_to(:complete)
      end

      it 'returns truthy' do
        expect(cs_accelerator_enrolment.current_state).to eq(:complete.to_s)
        expect(secondary_certificate.user_is_eligible?(user)).to be_truthy
      end
    end
  end

  describe '#path' do
    it 'returns the path for the programme' do
      expect(secondary_certificate.path)
        .to eq('/certificate/secondary-certificate')
    end
  end
end
