require "rails_helper"

RSpec.describe CertificatePendingTransitionJob, type: :job do
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:secondary_certificate) { create(:secondary_certificate) }
  let!(:cs_accelerator) { create(:cs_accelerator) }
  let!(:i_belong) { create(:i_belong) }
  let!(:a_level) { create(:a_level) }
  let!(:assessment) { create(:assessment, class_marker_test_id: "100", programme: a_level) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme_id: primary_certificate.id, user_id: user.id) }

  describe "#perform" do
    include ActiveJob::TestHelper

    context "when user is valid but not enrolled" do
      before do
        primary_certificate
      end

      it "doesn't cause errors" do
        expect do
          described_class.perform_now(user, {some_value: "10"})
        end.not_to raise_error
      end

      it "doesn't cause errors when performed later" do
        expect do
          described_class.perform_later(user, {source: "10"})
        end.not_to raise_error
      end
    end

    context "when no programme has no delay" do
      let(:a_level_enrolment) { create(:user_programme_enrolment, programme: a_level, user:) }

      before do
        a_level_enrolment
      end

      it "should transition to complete" do
        allow_any_instance_of(Programmes::ALevel).to receive(:user_meets_completion_requirement?).and_return(true)
        described_class.perform_now(user)
        expect(a_level_enrolment.current_state).to eq("complete")
      end
    end

    context "when has programme has delay" do
      let(:secondary_enrolment) { create(:user_programme_enrolment, programme: secondary_certificate, user:) }

      before do
        secondary_enrolment
      end

      it "should enqueue ScheduleCertificateCompletionJob for the correct time" do
        allow_any_instance_of(Programmes::SecondaryCertificate).to receive(:user_meets_completion_requirement?).and_return(true)
        expect {
          described_class.perform_now(user)
        }.to have_enqueued_job(ScheduleCertificateCompletionJob).with(secondary_enrolment)
          .at(a_value_within(1.seconds).of(Programme.secondary_certificate.pending_delay.from_now)) # Deal with inaccuracy of time checks
      end
    end

    context "when user is valid and enrolled" do
      before do
        allow_any_instance_of(Programmes::PrimaryCertificate).to receive(:user_meets_completion_requirement?).and_return(true)
        user_programme_enrolment
        described_class.perform_now(user, {some_value: "10"})
      end

      after do
        clear_enqueued_jobs
      end

      it "transitions to pending" do
        expect(user_programme_enrolment.current_state).to eq "pending"
      end

      it "metadata is stored" do
        expect(user_programme_enrolment.last_transition.metadata["some_value"]).to eq "10"
      end
    end
  end
end
