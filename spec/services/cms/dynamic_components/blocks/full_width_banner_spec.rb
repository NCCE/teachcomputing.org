require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::FullWidthBanner do
  before do
    @banner = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::FullWidthBanner.generate_raw_data)
  end

  it "should render as FullWidthBannerComponent" do
    expect(@banner.render).to be_a(Cms::FullWidthBannerComponent)
  end
end
