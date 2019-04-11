require 'rails_helper'

describe DashboardHelper, type: :helper do
  let(:user) { create(:user) }
  let(:diagnostic_tool_activity) { create(:activity, :diagnostic_tool) }
  let(:another_activity) { create(:activity) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }

  describe('#has_user_completed_activity?') do
    it 'returns false with no arguments' do
      expect(helper.has_user_completed_activity?(nil, nil)).to eq false
    end

    it 'returns false with no user' do
      expect(helper.has_user_completed_activity?(nil, another_activity)).to eq false
    end

    it 'returns false with no activity' do
      expect(helper.has_user_completed_activity?(user, nil)).to eq false
    end

    it 'returns false if user hasn\'t achieved activity' do
      achievement = diagnostic_achievement
      user = achievement.user
      expect(helper.has_user_completed_activity?(user, another_activity)).to eq false
    end

    it 'returns true if user has achieved activity' do
      achievement = diagnostic_achievement
      user = achievement.user
      expect(helper.has_user_completed_activity?(user, achievement.activity)).to eq true
    end
  end
end
