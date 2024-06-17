require "rails_helper"

RSpec.describe QuestionnaireResponseTransition, type: :model do
  let(:questionnaire_response) { create(:questionnaire_response) }
  let!(:transition1) { create(:questionnaire_response_transition, questionnaire_response: questionnaire_response, sort_key: 1, most_recent: false, to_state: "in_progress") }
  let!(:transition2) { create(:questionnaire_response_transition, questionnaire_response: questionnaire_response, sort_key: 2, most_recent: true, to_state: "complete") }

  describe "associations" do
    it { is_expected.to belong_to(:questionnaire_response) }
  end

  describe "validations" do
    it { is_expected.to validate_inclusion_of(:to_state).in_array(StateMachines::QuestionnaireResponseStateMachine.states) }
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
