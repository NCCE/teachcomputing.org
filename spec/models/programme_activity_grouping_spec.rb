require 'rails_helper'

RSpec.describe ProgrammeActivityGrouping, type: :model do
  let(:programme_activity_grouping) { create(:programme_activity_grouping) }

  describe 'associations' do
    it 'has_many programme_activities' do
      expect(programme_activity_grouping).to have_many(:programme_activities)
    end

    it 'belongs to programme' do
      expect(programme_activity_grouping).to belong_to(:programme)
    end
  end
end
