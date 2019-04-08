require 'rails_helper'

RSpec.describe('dashboard/_activity', type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:diagnostic_tool_activity) { create(:activity, :diagnostic_tool)}
  let(:removable_activity) { create(:activity, :user_removable)}
  let(:action_achievement) { create(:achievement, user_id: user.id, activity_id: activity.id) }
  let(:diagnostic_achievement) { create(:achievement, user_id: user.id, activity_id: diagnostic_tool_activity.id) }
  let(:removable_achievement) { create(:achievement, user_id: user.id, activity_id: removable_activity.id) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
  end

  context 'when the user has downloaded the diagnostic' do
    before do
      @achievements = [action_achievement, diagnostic_achievement, removable_achievement]
      render
    end

    it 'has the signed up item' do
      expect(rendered).to have_css('.ncce-activity-list__item', text: 'Signed up to the National Centre for Computing Education')
    end

    it 'check for every achievements title' do
      @achievements.each do |achievement|
        expect(rendered).to have_css('.ncce-activity-list__item-text', text: achievement.activity.title)
      end
    end

    it 'has a remove link for self removable courses' do
      expect(rendered).to have_xpath("//a[@title='Remove #{removable_activity.title}']",
                                      :class => "ncce-activity-list__item-remove", text: 'Remove')
    end

    it 'has a remove link for self removable courses only' do
      expect(rendered).to have_css('.ncce-activity-list__item-remove', count: 1)
    end

    it 'has the collapsible add form title' do
      expect(rendered).to have_css('.ncce-collapsible-activity__title-button', text: /.*Add a course you've completed.*/)
    end

    it 'has the collapsible form select' do
      expect(rendered).to have_css('.ncce-activity-form__select', count: 1)
    end

    it 'has the collapsible form button' do
      expect(rendered).to have_css('.ncce-activity-form__button--pink', count: 1)
    end

    it 'doesn\'t have the download diagnostic item' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 0)
    end
  end

  context 'when the user hasn\'t downloaded the diagnostic' do
    before do
      @achievements = [action_achievement, removable_achievement]
      render
    end

    it 'shows the download diagnostic item' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', text: /.*Download the diagnostic tool*/, count: 1)
    end
  end
end
