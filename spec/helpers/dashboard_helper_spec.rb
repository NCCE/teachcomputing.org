require 'rails_helper'

describe DashboardHelper, type: :helper do
  let(:user) { create(:user) }
  let(:diagnostic_tool_activity) { create(:activity, :diagnostic_tool)}
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }

  describe('#has_downloaded_diagnostic?') do
    it 'returns false' do
      expect(helper.has_downloaded_diagnostic?([])).to eq false
    end

    it 'returns true' do
      download_diagnostic = diagnostic_achievement
      expect(helper.has_downloaded_diagnostic?([download_diagnostic])).to eq true
    end
  end
end
