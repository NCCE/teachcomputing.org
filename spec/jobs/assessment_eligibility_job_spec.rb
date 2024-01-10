require "rails_helper"

RSpec.describe AssessmentEligibilityJob, type: :job do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment) do
    create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id)
  end

  describe "#perform" do
    before do
      [user, cs_accelerator_enrolment]
    end

    it "does not call CSAcceleratorMailer when the user does not have enough activities for the test" do
      expect { described_class.perform_now(user.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(0)
    end

    it "does not call CSAcceleratorMailer when the enrolment is already in a state of complete" do
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:enough_activities_for_test?).with(user).and_return(true)
      cs_accelerator_enrolment.transition_to(:complete)
      expect { described_class.perform_now(user.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(0)
    end

    it "does not call CSAcceleratorMailer when the enrolment is in a state of unenrolled" do
      allow_any_instance_of(Programmes::CSAccelerator)
        .to receive(:enough_activities_for_test?)
        .with(user)
        .and_return(true)
      cs_accelerator_enrolment.transition_to(:unenrolled)
      expect { described_class.perform_now(user.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(0)
    end

    it "does not call CSAcceleratorMailer when the user does not have an enrolment" do
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:enough_activities_for_test?).with(user).and_return(true)
      cs_accelerator_enrolment.destroy
      expect { described_class.perform_now(user.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(0)
    end

    it "sends the email" do
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:enough_activities_for_test?).with(user).and_return(true)
      expect { described_class.perform_now(user.id) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "records the email has been sent for the user" do
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:enough_activities_for_test?).with(user).and_return(true)
      expect { described_class.perform_now(user.id) }
        .to change(SentEmail, :count).by(1)
    end

    it "only sends the email once" do
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:enough_activities_for_test?).with(user).and_return(true)
      described_class.perform_now(user.id)
      expect do
        described_class.perform_now(user.id)
      end
        .to change(SentEmail, :count).by(0)
    end
  end
end
