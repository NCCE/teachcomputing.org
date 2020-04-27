require 'rails_helper'

RSpec.describe NewAssessmentEligibilityJob, type: :job do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id) }

  describe '#perform' do
    before do
      [user, cs_accelerator_enrolment]
    end

    it 'does not call CsAcceleratorMailer when the user does not have enough activities for the test' do
        expect { described_class.perform_now(user.id) }
          .to change { ActionMailer::Base.deliveries.count }.by(0)
    end

    it 'does not call CsAcceleratorMailer when the enrolment is already in a state of complete' do
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:enough_activites_for_test?).with(user).and_return(true)
      cs_accelerator_enrolment.transition_to(:complete)
      expect { described_class.perform_now(user.id) }
      .to change { ActionMailer::Base.deliveries.count }.by(0)
    end

    it 'does not call CsAcceleratorMailer when the user does not have an enrolment' do
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:enough_activites_for_test?).with(user).and_return(true)
      cs_accelerator_enrolment.destroy
      expect { described_class.perform_now(user.id) }
      .to change { ActionMailer::Base.deliveries.count }.by(0)
    end

    it 'mails if the user is eligible' do
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:enough_activites_for_test?).with(user).and_return(true)
        expect { described_class.perform_now(user.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
