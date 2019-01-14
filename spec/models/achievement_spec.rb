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
end