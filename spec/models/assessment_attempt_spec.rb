require 'rails_helper'

RSpec.describe AssessmentAttempt, type: :model do
  let(:assessment_attempt) { create(:assessment_attempt) }

  describe 'associations' do
    it 'belongs to assessment' do
      expect(assessment_attempt).to belong_to(:assessment)
    end

    it 'belongs to user' do
      expect(assessment_attempt).to belong_to(:user)
    end
  end
end
