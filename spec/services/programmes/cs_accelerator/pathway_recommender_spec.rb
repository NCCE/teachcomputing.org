require "rails_helper"

RSpec.describe Programmes::CSAccelerator::PathwayRecommender do
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:recommender) { described_class.new(questionnaire_response: questionnaire_response) }

  let(:questionnaire_response) { create(:questionnaire_response, answers: answers) }

  let!(:new_to_computing_pathway) { create(:new_to_computing) }
  let!(:preparing_to_teach_pathway) { create(:prepare_to_teach_gcse_computer_science) }
  let!(:algorithms_and_programming_pathway) { create(:new_to_algorithms_and_programming) }
  let!(:systems_pathway) { create(:new_to_computer_systems) }
  let!(:advanced_pathway) { create(:advanced_gcse_computer_science) }

  describe "#recommended_pathway" do
    context 'when user answered "A" to question 1' do
      let(:answers) { {"1": "1"} }

      it 'recommends "New to computing" pathway' do
        expect(recommender.recommended_pathway).to eq(new_to_computing_pathway)
      end
    end

    context 'when user answered "A" to question 1 and has further answers' do
      let(:answers) { {"1": "1", "2": "2", "3": "3", "4": "2", "5": "2"} }

      it 'recommends "New to computing" pathway' do
        expect(recommender.recommended_pathway).to eq(new_to_computing_pathway)
      end
    end

    context "when score is 10 or less" do
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

    context "when score is between 11 and 14" do
      let(:answers) { {"1": "3", "2": "2", "3": "2", "4": "2", "5": "2"} }

      it 'recommends "Preparing to teach GCSE Computer Science" pathway' do
        expect(recommender.recommended_pathway).to eq(preparing_to_teach_pathway)
      end
    end

    context 'when score is between 11 and 14 and there was only one "A" or "B" response' do
      context 'when Q1 has a "B" response' do
        let(:answers) { {"1": "2", "2": "3", "3": "3", "4": "3", "5": "3"} }

        it 'recommends "Preparing to teach GCSE Computer Science" pathway' do
          expect(recommender.recommended_pathway).to eq(preparing_to_teach_pathway)
        end
      end

      context 'when "A" or "B" relates to Q2' do
        let(:answers) { {"1": "3", "2": "2", "3": "3", "4": "3", "5": "3"} }

        it 'recommends "new to Algorithms & Programming" pathway' do
          expect(recommender.recommended_pathway).to eq(algorithms_and_programming_pathway)
        end
      end

      context 'when "A" or "B" relates to Q4' do
        let(:answers) { {"1": "3", "2": "3", "3": "3", "4": "2", "5": "3"} }

        it 'recommends "new to Algorithms & Programming" pathway' do
          expect(recommender.recommended_pathway).to eq(algorithms_and_programming_pathway)
        end
      end

      context 'when "A" or "B" relates to Q3' do
        let(:answers) { {"1": "3", "2": "3", "3": "2", "4": "3", "5": "3"} }

        it 'recommends "new to Systems" pathway' do
          expect(recommender.recommended_pathway).to eq(systems_pathway)
        end
      end

      context 'when "A" or "B" relates to Q5' do
        let(:answers) { {"1": "3", "2": "3", "3": "3", "4": "3", "5": "2"} }

        it 'recommends "new to Systems" pathway' do
          expect(recommender.recommended_pathway).to eq(systems_pathway)
        end
      end
    end

    context "when score is between 15 and 20" do
      let(:answers) { {"1": "3", "2": "3", "3": "3", "4": "3", "5": "3"} }

      it 'recommends "advanced GCSE Computer Science" pathway' do
        expect(recommender.recommended_pathway).to eq(advanced_pathway)
      end

      context 'when there is more than 1 "A" or "B" response' do
        let(:answers) { {"1": "4", "2": "2", "3": "1", "4": "4", "5": "4"} }

        it 'recommends "Preparing to teach GCSE Computer Science" pathway' do
          expect(recommender.recommended_pathway).to eq(preparing_to_teach_pathway)
        end
      end

      context 'When question 1 has a "B" response' do
        let(:answers) { {"1": "2", "2": "4", "3": "3", "4": "3", "5": "3"} }

        it 'recommends "Preparing to teach GCSE Computer Science" pathway' do
          expect(recommender.recommended_pathway).to eq(preparing_to_teach_pathway)
        end
      end

      context 'when there is one "A" or "B" relating to Q2' do
        let(:answers) { {"1": "3", "2": "2", "3": "3", "4": "3", "5": "4"} }

        it 'recommends "Algorithms & Programming" pathway' do
          expect(recommender.recommended_pathway).to eq(algorithms_and_programming_pathway)
        end
      end

      context 'when there is one "A" or "B" relating to Q4' do
        let(:answers) { {"1": "3", "2": "3", "3": "4", "4": "1", "5": "4"} }

        it 'recommends "Algorithms & Programming" pathway' do
          expect(recommender.recommended_pathway).to eq(algorithms_and_programming_pathway)
        end
      end

      context 'when there is one "A" or "B" relating to Q3' do
        let(:answers) { {"1": "3", "2": "3", "3": "2", "4": "3", "5": "4"} }

        it 'recommends "new to computer systems' do
          expect(recommender.recommended_pathway).to eq(systems_pathway)
        end
      end

      context 'when there is one "A" or "B" relating to Q5' do
        let(:answers) { {"1": "3", "2": "3", "3": "4", "4": "4", "5": "1"} }

        it 'recommends "new to computer systems' do
          expect(recommender.recommended_pathway).to eq(systems_pathway)
        end
      end
    end
  end
end
