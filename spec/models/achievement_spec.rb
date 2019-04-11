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

  describe 'state' do
    context 'default' do
      subject { Achievement.in_state(:commenced) }

      it { is_expected.to include achievement }
    end

    context 'completed' do
      subject { Achievement.in_state(:completed) }

      it { is_expected.not_to include achievement }
    end
  end
end
