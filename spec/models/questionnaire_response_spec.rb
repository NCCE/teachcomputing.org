require "rails_helper"

RSpec.describe QuestionnaireResponse, type: :model do
  let(:questionnaire_response) { create(:questionnaire_response) }
  let(:answer) { "This is my answer" }
  let(:add_answer) do
    questionnaire_response.answer_current_question(1, answer, 2)
    questionnaire_response.save
    questionnaire_response
  end

  describe "associations" do
    it "belongs to a questionnaire" do
      expect(questionnaire_response).to belong_to(:questionnaire)
    end

    it "belongs to a user" do
      expect(questionnaire_response).to belong_to(:user)
    end
  end

  describe "validations" do
    before do
      questionnaire_response
    end

    it { is_expected.to validate_uniqueness_of(:user_id).case_insensitive.scoped_to(:questionnaire_id) }
  end

  describe "#add_answer" do
    it "saves the answer correctly" do
      expect(add_answer.answers["1"]).to eq(answer)
    end

    it "updates the current_question correctly" do
      expect(add_answer.current_question).to eq(2)
    end
  end

  describe "#score" do
    it "returns the correct score" do
      response = create(:questionnaire_response, answers: {"1": "2", "2": "3", "4": "20", "5": "32"})
      expect(response.score).to eq(57)
    end
  end

  describe "state" do
    it "initializes with the correct initial state" do
      expect(QuestionnaireResponse.in_state(:in_progress)).to include(questionnaire_response)
    end

    it "transitions from in_progress to complete" do
      questionnaire_response.state_machine.transition_to(:complete)
      expect(QuestionnaireResponse.in_state(:complete)).to include(questionnaire_response)
    end
  end

  describe "delegate methods" do
    it { is_expected.to delegate_method(:can_transition_to?).to(:state_machine).as(:can_transition_to?) }
    it { is_expected.to delegate_method(:current_state).to(:state_machine).as(:current_state) }
    it { is_expected.to delegate_method(:transition_to).to(:state_machine).as(:transition_to) }
    it { is_expected.to delegate_method(:last_transition).to(:state_machine).as(:last_transition) }
  end

  describe "#complete!" do
    it "when state is not complete" do
      expect { questionnaire_response.complete! }
        .to change(questionnaire_response, :complete?)
        .from(false).to(true)
    end

    it "when state is complete" do
      questionnaire_response.transition_to(:complete)
      expect(questionnaire_response.complete!).to be false
    end
  end

  describe "#complete?" do
    it "when state is not complete" do
      expect(questionnaire_response.complete?).to be false
    end

    it "when state is complete" do
      questionnaire_response.transition_to(:complete)
      expect(questionnaire_response.complete?).to be true
    end
  end
end
