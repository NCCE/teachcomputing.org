require 'rails_helper'

RSpec.describe Assessment, type: :model do
  let(:assessment) { create(:assessment) }

  describe 'associations' do
    it 'belongs to programme' do
      expect(assessment).to belong_to(:programme)
    end

    it 'belongs to activity' do
      expect(assessment).to belong_to(:activity)
    end

    it 'has_one assessment_counter' do
      expect(assessment).to have_one(:assessment_counter)
    end
  end
end
