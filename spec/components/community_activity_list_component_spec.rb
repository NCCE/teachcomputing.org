require 'rails_helper'

RSpec.describe CommunityActivityListComponent, type: :component do
  let(:programme_activities) { [] }
  let(:community_achievements) { [] }
  let(:tracking_category) { 'foo' }

  before do
    render_inline(described_class.new(programme_activities:, community_achievements:, tracking_category:))
  end

  it 'should not have expander' do
    expect(page).to have_no_css('.community-activity-list--show-hide')
  end

  context 'with only four programme activities' do
    let(:programme_activities) { create_list(:programme_activity, 4) }

    it 'should not have expander' do
      expect(page).to have_no_css('.community-activity-list--show-hide')
    end
  end

  context 'with 5 programme activities' do
    let(:programme_activities) { create_list(:programme_activity, 5) }

    it 'should have expander' do
      expect(page).to have_css('.community-activity-list--show-hide')
    end
  end

  context 'with only completed activities' do
    let(:programme_activities) { create_list(:programme_activity, 3) }
    let(:community_achievements) { programme_activities.map { |pa| create(:completed_achievement, activity: pa.activity) } }

    it 'sould not have expander' do
      expect(page).to have_no_css('.community-activity-list--show-hide')
    end
  end

  context 'with completed and non completed activities less than four' do
    let(:programme_activities) { create_list(:programme_activity, 3) }
    let(:community_achievements) { programme_activities.first(1).map { |pa| create(:completed_achievement, activity: pa.activity) } }

    it 'sould have expander' do
      expect(page).to have_css('.community-activity-list--show-hide')
    end
  end
end
