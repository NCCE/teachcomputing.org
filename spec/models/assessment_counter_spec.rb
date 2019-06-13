require 'rails_helper'

RSpec.describe AssessmentCounter, type: :model do
  let(:assessment) { create(:assessment) }
  let(:assessment_counter) { create(:assessment_counter, counter: 0, assessment_id: assessment.id) }

  describe 'associations' do
    it 'belongs to assessment' do
      expect(assessment_counter).to belong_to(:assessment)
    end

    it 'increments the counter' do
      expect { assessment_counter.get_next_number }.to change { assessment_counter.counter }.by(1)
    end

    it 'returns the counter + 1' do
      count = assessment_counter.get_next_number
      expect(assessment_counter.get_next_number).to eq (count + 1)
    end
  end
end
