require 'rails_helper'

RSpec.describe AssessmentAttempt do
  let(:assessment) { create(:assessment) }
  let(:assessment_attempt) { create(:assessment_attempt, assessment_id: assessment.id) }
  let(:user) { create(:user) }
  let(:passed_attempt) { create(:completed_assessment_attempt, user_id: user.id, assessment_id: assessment.id) }
  let(:failing_user) { create(:user) }
  let(:failed_attempt) { create(:failed_assessment_attempt, user_id: failing_user.id, assessment_id: assessment.id) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:accepted_conditions) }
  end

  describe 'associations' do
    it 'belongs to assessment' do
      expect(assessment_attempt).to belong_to(:assessment)
    end

    it 'belongs to user' do
      expect(assessment_attempt).to belong_to(:user)
    end
  end

  describe 'delegate methods' do
    it { is_expected.to delegate_method(:can_transition_to?).to(:state_machine).as(:can_transition_to?) }
    it { is_expected.to delegate_method(:current_state).to(:state_machine).as(:current_state) }
    it { is_expected.to delegate_method(:transition_to).to(:state_machine).as(:transition_to) }
    it { is_expected.to delegate_method(:last_transition).to(:state_machine).as(:last_transition) }
  end

  describe '#for_user' do
    it 'when user has attempted the assessment' do
      user
      passed_attempt
      expect(described_class.for_user(user)).to include(passed_attempt)
    end

    it 'when user has not attempted the assessment' do
      failed_attempt
      expect(described_class.for_user(user)).not_to include(failed_attempt)
    end
  end
end
