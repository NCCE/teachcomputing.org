require "rails_helper"

RSpec.describe "rake schedule_eligible_pending_enrolments", type: :task do
  let(:programme) { create(:secondary_certificate) }
  let!(:enrolment) { create(:user_programme_enrolment, programme:) }

  describe "can complete" do
    before do
      allow_any_instance_of(Programmes::SecondaryCertificate).to receive(:user_meets_completion_requirement?).and_return(true)
    end
    it "should enqueue CertificatePendingTranisitionJob" do
      expect {
        task.execute
      }.to have_enqueued_job(CertificatePendingTransitionJob)
    end
  end

  describe "when cannot complete" do
    before do
      allow_any_instance_of(Programmes::SecondaryCertificate).to receive(:user_meets_completion_requirement?).and_return(false)
    end
    it "should not enqeue CertificatePendingTranistionJob" do
      expect {
        task.execute
      }.to_not have_enqueued_job(CertificatePendingTransitionJob)
    end
  end
end
