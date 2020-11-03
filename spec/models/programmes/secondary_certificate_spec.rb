
require 'rails_helper'

RSpec.describe Programmes::SecondaryCertificate do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: cs_accelerator.id) }
  let(:secondary_certificate) { create(:secondary_certificate) }

  describe '#csa_eligible_courses' do
    context 'without a CS Accelerator enrolment' do
      it 'returns nil' do
        cs_accelerator
        expect(secondary_certificate.csa_eligible_courses(user)).to eq nil
      end
    end

    it 'returns a collection of eligble courses' do
      cs_accelerator_enrolment.transition_to(:complete)
      create(:achievement, user_id: user.id, programme_id: cs_accelerator.id).transition_to(:complete)
      expect(secondary_certificate.csa_eligible_courses(user).count).to eq 1
    end
  end

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
end
