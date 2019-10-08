require 'rails_helper'

RSpec.describe('programmes/_community_achievements', type: :view) do
  let(:user) { create(:user) }
  let(:community_activity) { create(:activity, :community) }
  let(:complete_achievement) { create(:completed_achievement, user_id: user.id, activity_id: community_activity.id) }
  let(:second_community_activity) { create(:activity, :community, slug: 'second-community-activity') }
  let(:second_complete_achievement) { create(:completed_achievement, user_id: user.id, activity_id: second_community_activity.id) }

  context 'when user has not completed any achievements' do
    before do
      presenters = [CommunityPresenter.new(community_activity), CommunityPresenter.new(second_community_activity)]
      render partial: 'programmes/community_achievements', locals: { presenters: presenters }
    end

    it 'both achievements are  marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 2)
    end

    it 'has the buttons to self verify' do
      expect(rendered).to have_css('.ihavedonethis__button', count: 2)
    end
  end

  context 'when user has finished one achievement' do
    before do
      complete_achievement
      presenters = [CommunityPresenter.new(community_activity), CommunityPresenter.new(second_community_activity)]
      render partial: 'programmes/community_achievements', locals: { presenters: presenters }
    end

    it 'one achievement is  marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 1)
    end

    it 'has one button to self verify' do
      expect(rendered).to have_css('.ihavedonethis__button', count: 1)
    end
  end

  context 'when user has finished both achievements' do
    before do
      complete_achievement
      second_complete_achievement
      presenters = [CommunityPresenter.new(community_activity), CommunityPresenter.new(second_community_activity)]
      render partial: 'programmes/community_achievements', locals: { presenters: presenters }
    end

    it 'no achievements are  marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 0)
    end

    it 'has no buttons to self verify' do
      expect(rendered).to have_css('.ihavedonethis__button', count: 0)
    end
  end
end
