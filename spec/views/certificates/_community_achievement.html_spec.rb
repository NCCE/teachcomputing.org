require 'rails_helper'

RSpec.describe('certificates/_community_achievement', type: :view) do
  let(:programme) { create(:programme) }
  let(:user) { create(:user) }
  let(:community_activity) { create(:activity, :community) }
  let(:complete_achievement) { create(:completed_achievement, user_id: user.id, activity_id: community_activity.id, programme_id: programme.id) }
  let(:second_community_activity) { create(:activity, :community, slug: 'second-community-activity') }
  let(:second_complete_achievement) { create(:completed_achievement, user_id: user.id, activity_id: second_community_activity.id, programme_id: programme.id) }
  let(:presenters) do
    [CommunityPresenter.new(community_activity, programme.id), CommunityPresenter.new(second_community_activity, programme.id)]
  end

  before do
    assign(:programme, programme)
  end

  context 'when user has not completed any achievements' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render partial: 'certificates/community_achievement', locals: { presenter: presenters[0] }
    end

    it 'both achievements are marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 1)
    end

    it 'has the buttons to self verify' do
      expect(rendered).to have_css('.ihavedonethis__button', count: 1)
    end

    it 'has different ids for each form\'s input' do
      expect(rendered).to have_field('self_verification_info', id: /#{presenters[0].id}/)
    end
  end

  context 'when user has finished one achievement' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      complete_achievement
      render partial: 'certificates/community_achievement', locals: { presenter: presenters[1] }
    end

    it 'has a button to self verify' do
      expect(rendered).to have_css('.ihavedonethis__button', count: 1)
    end
  end

  context 'when user has finished both achievements' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      complete_achievement
      second_complete_achievement
      render partial: 'certificates/community_achievement', locals: { presenter: presenters[0] }
    end

    it 'no achievements are marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 0)
    end

    it 'has no buttons to self verify' do
      expect(rendered).to have_css('.ihavedonethis__button', count: 0)
    end
  end
end
