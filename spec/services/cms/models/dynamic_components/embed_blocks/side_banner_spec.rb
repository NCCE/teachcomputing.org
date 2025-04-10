require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::EmbedBlocks::SideBanner do
  before do
    @comp = Cms::Providers::Strapi::Factories::EmbedBlocksFactory.to_side_banner(
      {banner: Cms::Mocks::DynamicComponents::EmbedBlocks::SideBanner.generate_data}
    )
  end

  it "should render as Cms::SideBannerComponent" do
    expect(@comp.render).to be_a(Cms::SideBannerComponent)
  end
end
