require 'rails_helper'

RSpec.describe Assessment, type: :model do
  let(:assessment) { create(:assessment) }

  describe 'associations' do
    it 'belongs to programme' do
      expect(assessment).to belong_to(:programme)
    end
  end
end
