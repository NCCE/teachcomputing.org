require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::CommunityActivityGrid do
  let(:cms_slug) { "cms-dynamic-comp-comm-act" }
  let!(:programme_activity_group) { create(:programme_activity_grouping, cms_slug:) }

  before do
    data = Cms::Mocks::DynamicComponents::Blocks::CommunityActivityGrid.generate_raw_data(
      group: {data: {attributes: {slug: cms_slug}}}
    )
    @list = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(data)
  end

  it "should render as Cms::CommunityActivityListComponent" do
    expect(@list.render).to be_a(Cms::CommunityActivityGridComponent)
  end
end
