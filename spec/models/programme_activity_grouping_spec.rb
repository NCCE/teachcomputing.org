require 'rails_helper'

RSpec.describe ProgrammeActivityGrouping, type: :model do
  let(:programme) { create(:programme) }
  let(:programme_activity_grouping) { create(:programme_activity_grouping)}
  let(:programme_activity_groupings) { create_list(:programme_activity_grouping, 3, :with_activities, programme: programme) }
  let(:user) { create(:user) }

  describe 'associations' do
    it 'has_many programme_activities' do
      expect(programme_activity_grouping).to have_many(:programme_activities)
    end

    it 'belongs to programme' do
      expect(programme_activity_grouping).to belong_to(:programme)
    end
  end

  describe '#user_complete?' do
    before do
      programme_activity_groupings
      user
    end

    context 'when the user has not completed the required number of activities' do
      it 'returns false' do
        grouping = programme_activity_groupings.first
        expect(grouping.user_complete?(user)).to eq nil
      end
    end

    context 'when the user has completed the required number of activities' do
      before do
        achievement = create(:achievement, user_id: user.id, programme_id: programme.id, activity_id: programme_activity_groupings.first.programme_activities.first.activity.id)
        achievement.transition_to(:complete)
      end
      it 'returns true' do
        grouping = programme_activity_groupings.first
        expect(grouping.user_complete?(user)).to eq true
      end
    end
  end
end
