require 'rails_helper'

RSpec.describe ProgrammeActivity, type: :model do
  let(:programme_activity) { create(:programme_activity) }

  describe 'associations' do
    it 'belongs to activity' do
      expect(programme_activity).to belong_to(:activity)
    end

    it 'belongs to programme' do
      expect(programme_activity).to belong_to(:programme)
    end

    it 'belongs to programme activity grouping' do
      expect(programme_activity).to belong_to(:programme_activity_grouping)
    end
  end
end
