require "rails_helper"

RSpec.describe Cms::DynamicComponents::FullWidthBanner do
  before do
    @button = Cms::Providers::Strapi::Factories::ComponentFactory.to_full_width_banner(Cms::Mocks::FullWidthBanner.generate_data)
  end

  it "should render as CmsFullWidthBannerComponent" do
    expect(@button.render).to be_a(CmsFullWidthBannerComponent)
  end
end
