require "rails_helper"

RSpec.describe StateMachines::QuestionnaireResponseStateMachine do
  let(:questionnaire_response) { create(:questionnaire_response) }

  describe "initial state" do
    it "returns in_progress" do
      expect(described_class.initial_state).to eq "in_progress"
    end
  end

  describe "guards" do
    it "can transition from state in_progress to state complete" do
      expect { questionnaire_response.state_machine.transition_to!(:complete) }
        .not_to raise_error
    end
  end
end
