require 'rails_helper'

RSpec.describe AssessmentAttempt, type: :model do
  let(:assessment) { create(:assessment)}
  let(:assessment_attempt) { create(:assessment_attempt, assessment_id: assessment.id) }
  let(:passing_user) { create(:user) }
  let(:second_passing_user) { create(:user) }
  let(:failing_user) { create(:user) }
  let(:passed_attempt) { create(:completed_assessment_attempt, user_id: passing_user.id, assessment_id: assessment.id) }
  let(:second_passed_attempt) { create(:completed_assessment_attempt, user_id: second_passing_user.id, assessment_id: assessment.id) }
  let(:failed_attempt) { create(:failed_assessment_attempt, user_id: failing_user.id, assessment_id: assessment.id) }

  describe 'associations' do
    it 'belongs to assessment' do
      expect(assessment_attempt).to belong_to(:assessment)
    end

    it 'belongs to user' do
      expect(assessment_attempt).to belong_to(:user)
    end
  end

  describe '#passed_attempts_with_user' do
    before do
      [passed_attempt, second_passed_attempt, failed_attempt]
    end

    it 'returns the passed assessments' do
      [passed_attempt, second_passed_attempt].each do |attempt|
        expect(AssessmentAttempt.passed_attempts_with_user).to include(attempt)
      end
    end

    it 'doesn\'t include failed assessments' do
      expect(AssessmentAttempt.passed_attempts_with_user).to_not include(failed_attempt)
    end

    it 'ordering is correct' do
      [passing_user, second_passing_user].each_with_index do |user, index|
        expect(AssessmentAttempt.passed_attempts_with_user[index].user_id).to eq(user.id)
      end
    end
  end
end
