require 'rails_helper'

RSpec.describe('dashboard/_activity', type: :view) do
  let!(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:diagnostic_tool_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:removable_activity) { create(:activity, :user_removable) }
  let(:action_achievement) { create(:achievement, user_id: user.id, activity_id: activity.id) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }
  let(:removable_achievement) { create(:achievement, user_id: user.id, activity_id: removable_activity.id) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
  end

  context 'when the user has not taken the diagnostic' do
    before do
      @achievements = [action_achievement]
      @current_user = user
      render
    end

    it 'has one achievement' do
      expect(rendered).to have_css('.ncce-activity-list__item-text', count: 1)
    end

    it 'doesn\'t have the completed diagnostic achievement' do
      expect(rendered).to_not have_css('.ncce-activity-list__item-text', text: /diagnostic/)
    end
  end

  context 'when the user has taken the diagnostic' do
    before do
      @achievements = [action_achievement, diagnostic_achievement, removable_achievement]
      @current_user = user
      render
    end

    it 'check for every achievements title' do
      @achievements.each do |achievement|
        expect(rendered).to have_css('.ncce-activity-list__item-text', text: achievement.activity.title)
      end
    end
  end
end
