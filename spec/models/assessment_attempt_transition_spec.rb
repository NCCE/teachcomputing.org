require "rails_helper"

RSpec.describe AssessmentAttemptTransition, type: :model do
  let(:assessment) { create(:assessment) }
  let(:assessment_attempt) { create(:assessment_attempt, assessment_id: assessment.id) }
  let!(:transition1) { create(:assessment_attempt_transition, assessment_attempt: assessment_attempt, sort_key: 1, most_recent: false, to_state: "commenced") }
  let!(:transition2) { create(:assessment_attempt_transition, assessment_attempt: assessment_attempt, sort_key: 2, most_recent: true, to_state: "passed") }

  describe "associations" do
    it { is_expected.to belong_to(:assessment_attempt) }
  end

  describe "validations" do
    it { is_expected.to validate_inclusion_of(:to_state).in_array(StateMachines::AssessmentAttemptStateMachine.states) }
  end

  describe "callbacks" do
    context "after_destroy" do
      it "updates the most recent transition if the destroyed transition was the most recent" do
        transition2.destroy

        transition1.reload
        expect(transition1.most_recent).to be true
      end

      it "does not update the most recent transition if the destroyed transition was not the most recent" do
        transition1.destroy

        transition2.reload
        expect(transition2.most_recent).to be true
      end
    end
  end
end
