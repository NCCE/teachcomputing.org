require 'rails_helper'

RSpec.describe CommunityPresenter do
  let(:empty_presenter) { described_class.new(nil) }
  let(:community_activity) { create(:activity, :community, description: 'this is a <strong>community</strong> activity') }
  let(:achievement) { create(:achievement, activity_id: community_activity.id) }
  let(:completed_achievement) { create(:completed_achievement, activity_id: community_activity.id ) }
  let(:incomplete_presenter) { described_class.new(community_activity) }
  let(:completed_presenter) {
    completed_achievement
    described_class.new(community_activity)
  }

  describe('empty?') do
    it 'returns true if the presenter has no delegate' do
      expect(empty_presenter.empty?).to eq(true)
    end

    it 'returns false if the presenter has a delegate' do
      expect(incomplete_presenter.empty?).to eq(false)
    end
  end

  describe('completed?') do
    it { expect(incomplete_presenter.completed?).to eq(false) }
    it { expect(completed_presenter.completed?).to eq(true) }
  end

  describe('button_label') do
    it { expect(incomplete_presenter.button_label).to eq('I have done this') }
  end

  describe('list_item_classes') do
    it { expect(incomplete_presenter.list_item_classes).to include('ncce-activity-list__item--incomplete') }
    it { expect(incomplete_presenter.list_item_classes(true)).to include('ncce-activity-list__item--disabled') }
    it { expect(completed_presenter.list_item_classes(true)).to be(nil) }
  end

  describe('description') do
    it { expect(incomplete_presenter.description).to eq('this is a <strong>community</strong> activity') }
  end

  describe('inspect') do
    it { expect(incomplete_presenter.inspect).to start_with("CommunityPresenter - completed? false") }
  end
end
