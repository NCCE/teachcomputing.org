require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::ContentBlocks::SideBanner do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::ContentBlocks::SideBanner.generate_raw_data
    )
  end

  it "should render as Cms::SideBannerComponent" do
    expect(@comp.render).to be_a(Cms::SideBannerComponent)
  end
end
