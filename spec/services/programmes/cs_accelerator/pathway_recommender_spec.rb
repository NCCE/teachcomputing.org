require 'rails_helper'

RSpec.describe Programmes::CSAccelerator::PathwayRecommender do
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:recommender) { described_class.new(questionnaire_response: questionnaire_response) }

  let(:questionnaire_response) { create(:questionnaire_response, programme: cs_accelerator, answers: answers) }

  let!(:new_to_computing_pathway) { create(:pathway, slug: 'new_to_computing') }
  let!(:preparing_to_teach_pathway) { create(:pathway, slug: 'preparing_to_teach') }
  let!(:algorithms_and_programming_pathway) { create(:pathway, slug: 'algorithms_and_programming') }
  let!(:systems_pathway) { create(:pathway, slug: 'systems') }
  let!(:advanced_pathway) { create(:pathway, slug: 'advanced') }

  describe '#recommended_pathway' do
    context 'when user answered "not confident" to question 1' do
      let(:answers) { { '1': '1' } }

      it 'recommends "New to computing" pathway' do
        expect(recommender.recommended_pathway).to eq(new_to_computing_pathway)
      end
    end

    context 'when score is less than 10' do
      let(:questionnaire_response) { instance_double(QuestionnaireResponse) }

      before do
        allow(questionnaire_response).to receive(:answers).and_return({})
      end

      (2..10).each do |val|
        context "when score is #{val}" do
          it 'recommends "Preparing to teach GCSE Computer Science" pathway' do
            allow(questionnaire_response).to receive(:score).and_return(val)
            expect(recommender.recommended_pathway).to eq(preparing_to_teach_pathway)
          end
        end
      end
    end

    context 'when score is between 11 and 14' do
      let(:answers) { { '1': '3', '2': '2', '3': '2', '4': '2', '5': '2' } }

      it 'recommends "Preparing to teach GCSE Computer Science" pathway' do
        expect(recommender.recommended_pathway).to eq(preparing_to_teach_pathway)
      end
    end

    context 'when score is between 11 and 14 and there was only one "A" or "B" response' do
      context 'and B relates to Q1' do
        let(:answers) { { '1': '2', '2': '3', '3': '3', '4': '3', '5': '3' } }

        it 'recommends "Preparing to teach GCSE Computer Science" pathway' do
          expect(recommender.recommended_pathway).to eq(preparing_to_teach_pathway)
        end
      end

      context 'and A or B relates to Q2' do
        let(:answers) { { '1': '3', '2': '2', '3': '3', '4': '3', '5': '3' } }

        it 'recommends "Algorithms & Programming" pathway' do
          expect(recommender.recommended_pathway).to eq(algorithms_and_programming_pathway)
        end
      end

      context 'and A or B relates to Q4' do
        let(:answers) { { '1': '3', '2': '3', '3': '3', '4': '2', '5': '3' } }

        it 'recommends "Algorithms & Programming" pathway' do
          expect(recommender.recommended_pathway).to eq(algorithms_and_programming_pathway)
        end
      end

      context 'and A or B relates to Q3' do
        let(:answers) { { '1': '3', '2': '3', '3': '2', '4': '3', '5': '3' } }

        it 'recommends "Systems" pathway' do
          expect(recommender.recommended_pathway).to eq(systems_pathway)
        end
      end

      context 'and A or B relates to Q5' do
        let(:answers) { { '1': '3', '2': '3', '3': '3', '4': '3', '5': '2' } }

        it 'recommends "Systems" pathway' do
          expect(recommender.recommended_pathway).to eq(systems_pathway)
        end
      end
    end

    context 'when score is between 15 and 20' do
      let(:answers) { { '1': '3', '2': '3', '3': '3', '4': '3', '5': '3' } }

      it 'recommends "Advanced" pathway' do
        expect(recommender.recommended_pathway).to eq(advanced_pathway)
      end
    end

    context 'when score is between 15 and 20 and there are "A" or "B" responses' do
      context 'when there is one A or B relating to Q2' do
        let(:answers) { { '1': '3', '2': '2', '3': '3', '4': '3', '5': '4' } }

        it 'recommends "Algorithms & Programming" pathway' do
          expect(recommender.recommended_pathway).to eq(algorithms_and_programming_pathway)
        end
      end

      context 'when there is one A or B relating to Q4' do
        let(:answers) { { '1': '3', '2': '3', '3': '4', '4': '1', '5': '4' } }

        it 'recommends "Algorithms & Programming" pathway' do
          expect(recommender.recommended_pathway).to eq(algorithms_and_programming_pathway)
        end
      end

      context 'when there is one A or B relating to Q3' do
        let(:answers) { { '1': '3', '2': '3', '3': '2', '4': '3', '5': '4' } }

        it 'recommends "Systems" pathway' do
          expect(recommender.recommended_pathway).to eq(systems_pathway)
        end
      end

      context 'when there is one A or B relating to Q5' do
        let(:answers) { { '1': '3', '2': '3', '3': '4', '4': '4', '5': '1' } }

        it 'recommends "Systems" pathway' do
          expect(recommender.recommended_pathway).to eq(systems_pathway)
        end
      end
    end
  end
end
