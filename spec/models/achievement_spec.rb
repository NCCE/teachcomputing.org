require 'rails_helper'

RSpec.describe Achievement, type: :model do
  let(:achievement) { create(:achievement) }

  describe 'associations' do
    it 'belongs to activity' do
      expect(achievement).to belong_to(:activity)
    end

    it 'belongs to user' do
      expect(achievement).to belong_to(:user)
    end
  end

  describe 'validations' do
    before do
      achievement
    end

    it { is_expected.to validate_uniqueness_of(:user_id).case_insensitive.scoped_to(:activity_id) }
  end

  describe '#set_to_complete' do
    it 'when state is not complete' do
      achievement.set_to_complete
      expect(achievement.current_state).to eq 'complete'
    end

    it 'when state is complete' do
      achievement.transition_to(:complete)
      expect(achievement.set_to_complete).to eq false
    end
  end

  describe 'state' do
    context 'when default' do
      subject { Achievement.in_state(:commenced) }

      it { is_expected.to include achievement }
    end

    context 'when completed' do
      subject { Achievement.in_state(:completed) }

      it { is_expected.not_to include achievement }
    end
  end

  describe 'delegate methods' do
    it { is_expected.to delegate_method(:can_transition_to?).to(:state_machine).as(:can_transition_to?) }
    it { is_expected.to delegate_method(:current_state).to(:state_machine).as(:current_state) }
    it { is_expected.to delegate_method(:transition_to).to(:state_machine).as(:transition_to) }
  end

  describe 'destroy' do
    before do
      achievement
      achievement.transition_to(:complete)
    end

    it 'deletes transitions' do
      expect { achievement.destroy }.to change { AchievementTransition.count }.by(-1)
    end
  end
end
