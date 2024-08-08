require "rails_helper"

RSpec.describe ExpireAssessmentAttemptJob, type: :job do
  let(:assessment_attempt) { create(:assessment_attempt) }

  describe "#perform" do
    context "when the attempt is in a state of commenced" do
      it "transitions to failed" do
        ExpireAssessmentAttemptJob.perform_now(assessment_attempt)
        expect(assessment_attempt.current_state).to eq "timed_out"
      end
    end

    context "when the attempt is in a state of passed" do
      it "does not transition to failed" do
        assessment_attempt.transition_to(:passed)
        ExpireAssessmentAttemptJob.perform_now(assessment_attempt)
        expect(assessment_attempt.current_state).to eq "passed"
      end
    end
  end
end
