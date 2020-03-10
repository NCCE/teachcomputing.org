require 'rails_helper'

RSpec.describe QuestionnaireResponse, type: :model do
  let(:questionnaire_response) { create(:questionnaire_response) }
  let(:answer) { 'This is my answer' }
  let(:add_answer) {
    questionnaire_response.answer_current_question(answer)
    questionnaire_response.reload
    questionnaire_response
  }

  describe 'associations' do
    it 'belongs to a questionnaire' do
      expect(questionnaire_response).to belong_to(:questionnaire)
    end

    it 'belongs to a programme' do
      expect(questionnaire_response).to belong_to(:programme)
    end

    it 'belongs to a user' do
      expect(questionnaire_response).to belong_to(:user)
    end
  end

  describe 'validations' do
    before do
      questionnaire_response
    end

    it { is_expected.to validate_presence_of(:questionnaire_id) }
    it { is_expected.to validate_uniqueness_of(:user_id).case_insensitive.scoped_to(:programme_id, :questionnaire_id) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:programme_id) }
  end

  describe '#add_answer' do
    it 'saves the answer correctly' do
      expect(add_answer.answers['1']).to eq(answer)
    end

    it 'updates the current_question correctly' do
      expect(add_answer.current_question).to eq(1)
    end
  end
end
