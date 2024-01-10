require "rails_helper"

RSpec.describe CompleteCertificateEmailJob, type: :job do
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:primary) { create(:primary_certificate) }
  let(:secondary) { create(:secondary_certificate) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, programme_id: cs_accelerator.id) }
  let(:primary_enrolment) { create(:user_programme_enrolment, programme_id: primary.id) }
  let(:secondary_enrolment) { create(:user_programme_enrolment, programme_id: secondary.id) }

  describe "#perform" do
    context "when the programme is cs accelerator" do
      it "sends an email" do
        expect { described_class.perform_now(cs_accelerator_enrolment.user, cs_accelerator_enrolment.programme) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "when the programme is primary" do
      it "sends an email" do
        expect { described_class.perform_now(primary_enrolment.user, primary_enrolment.programme) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "when the programme is secondary" do
      it "sends an email" do
        expect { described_class.perform_now(secondary_enrolment.user, secondary_enrolment.programme) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
