require 'rails_helper'

RSpec.describe ProgrammeActivity, type: :model do
  let(:programme_activity) { create(:programme_activity) }

  describe 'associations' do
    it 'belongs to activity' do
      expect(programme_activity).to belong_to(:activity)
    end

    it 'belongs to user' do
      expect(programme_activity).to belong_to(:programme)
    end
  end
end
