require "rails_helper"

RSpec.describe CommunityActivityListComponent, type: :component do
  let(:programme_activities) { [] }
  let(:programme_activity_grouping) { create(:programme_activity_grouping) }
  let(:community_achievements) { [] }
  let(:tracking_category) { "foo" }

  before do
    programme_activities
    render_inline(described_class.new(programme_activity_grouping:, community_achievements:, tracking_category:))
  end

  it "should not have expander" do
    expect(page).to have_no_css(".community-activity-list--show-hide")
  end

  context "with only four programme activities" do
    let(:programme_activities) { create_list(:programme_activity, 4, programme_activity_grouping:) }

    it "should not have expander" do
      expect(page).to have_no_css(".community-activity-list--show-hide")
    end
  end

  context "with 5 programme activities" do
    let(:programme_activities) { create_list(:programme_activity, 5, programme_activity_grouping:) }

    it "should have expander" do
      expect(page).to have_css(".community-activity-list--show-hide")
    end
  end

  context "with only completed activities" do
    let(:programme_activities) { create_list(:programme_activity, 3, programme_activity_grouping:) }
    let(:community_achievements) { programme_activities.map { |pa| create(:completed_achievement, activity: pa.activity) } }

    it "sould not have expander" do
      expect(page).to have_no_css(".community-activity-list--show-hide")
    end
  end

  context "with completed and non completed activities less than four" do
    let(:programme_activities) { create_list(:programme_activity, 3, programme_activity_grouping:) }
    let(:community_achievements) { programme_activities.first(1).map { |pa| create(:completed_achievement, activity: pa.activity) } }

    it "sould have expander" do
      expect(page).to have_css(".community-activity-list--show-hide")
    end
  end
end
