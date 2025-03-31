require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::StickyDashboardBar do
  before do
    @bar = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::DynamicComponents::StickyDashboardBar.generate_raw_data)
  end

  it "should render as Cms::StickyDashboardBarComponent" do
    expect(@bar.render).to be_a(Cms::StickyDashboardBarComponent)
  end
end
