require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::FullWidthImageBanner do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::FullWidthImageBanner.generate_raw_data
    )
  end

  it "should render as Cms::FullWidthImageBannerComponent" do
    expect(@comp.render).to be_a(Cms::FullWidthImageBannerComponent)
  end
end
