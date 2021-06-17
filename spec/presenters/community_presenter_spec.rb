require 'rails_helper'

RSpec.describe CommunityPresenter do
  let(:programme) { create(:programme) }
  let(:community_activity) { create(:activity, :community, description: 'this is a <strong>community</strong> activity') }
  let(:achievement) { create(:achievement, activity_id: community_activity.id) }
  let(:completed_achievement) { create(:completed_achievement, activity_id: community_activity.id, user_id: user.id ) }
  let(:incomplete_presenter) { described_class.new(community_activity, programme.id) }
  let(:completed_presenter) {
    completed_achievement
    described_class.new(community_activity)
  }
  let(:user) { create(:user) }

  describe('completed?') do
    it { expect(incomplete_presenter.completed?(user)).to eq(false) }
    it { expect(completed_presenter.completed?(user)).to eq(true) }
  end

  describe('button_label') do
    it { expect(incomplete_presenter.button_label).to eq('I have done this') }
  end

  describe('list_item_classes') do
    it { expect(incomplete_presenter.list_item_classes(user)).to include('ncce-activity-list__item--incomplete') }
    it { expect(completed_presenter.list_item_classes(user)).to be(nil) }
  end

  describe('description') do
    it { expect(incomplete_presenter.description).to eq('this is a <strong>community</strong> activity') }
  end

  describe('inspect') do
    it { expect(incomplete_presenter.inspect).to start_with("CommunityPresenter") }
  end

  describe('self_verification_info') do
    it { expect(incomplete_presenter.self_verification_info).to eq('Please provide a link to your contribution') }
  end
end
