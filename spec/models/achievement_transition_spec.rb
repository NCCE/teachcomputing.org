require 'rails_helper'

RSpec.describe Achievement, type: :model do
  let(:completed_achievement) { create(:completed_achievement) }

  describe 'fix_missing_metadata' do
    before do
      completed_achievement
    end

    it 'is missing the test metadata' do
      expect(completed_achievement.last_transition.metadata['test']).to eq(nil)
    end

    it 'allows missing metadata to be fixed' do
      transition = completed_achievement.last_transition
      transition.fix_missing_metadata(test: 10)
      expect(transition.metadata['test']).to eq(10)
    end

    it 'doesn\'t overwrite pre-existing metadata' do
      transition = completed_achievement.last_transition
      transition.fix_missing_metadata(credit: 20)
      expect(transition.metadata['credit']).to eq(100)
    end
  end
end
