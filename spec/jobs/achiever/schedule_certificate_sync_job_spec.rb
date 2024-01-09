require "rails_helper"

RSpec.describe Achiever::ScheduleCertificateSyncJob, type: :job do
  let(:enrolment) { create(:user_programme_enrolment) }
  let(:my_instance) { instance_double(Achiever::User::Enrolment) }

  describe "#perform" do
    context "when the feature flag is enabled" do
      before do
        stub_post_enrolment
        allow(Achiever::User::Enrolment).to receive(:new).and_return(my_instance)
        allow(my_instance).to receive(:sync)
      end

      it "creates an AchieverSyncRecord" do
        expect { described_class.perform_now(enrolment.id) }
          .to change(AchieverSyncRecord, :count).by(1)
      end

      it "calls sync via Achiever::User::Enrolment" do
        described_class.perform_now(enrolment.id)
        expect(my_instance).to have_received(:sync)
      end

      it "does not create a sync record if one already exists" do
        create(:achiever_sync_record, user_programme_enrolment_id: enrolment.id)
        expect { described_class.perform_now(enrolment.id) }
          .not_to change(AchieverSyncRecord, :count)
      end
    end
  end
end
