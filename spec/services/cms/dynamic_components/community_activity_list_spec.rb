require "rails_helper"

RSpec.describe Cms::DynamicComponents::CommunityActivityList do
  let(:programme_activity_group) { create(:programme_activity_grouping) }
  before do
    data = Cms::Mocks::DynamicComponents::CommunityActivityList.generate_raw_data(
      programme_activity_group_slug: programme_activity_group.title
    )
    @list = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(data)
  end

  it "should render as Cms::CommunityActivityListComponent" do
    expect(@list.render).to be_a(Cms::CommunityActivityListComponent)
  end
end
