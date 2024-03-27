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
end
