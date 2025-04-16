require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::EmbedBlocks::SectionTitle do
  before do
    @comp = Cms::Providers::Strapi::Factories::EmbedBlocksFactory.to_section_title(
      {gridRowTitle: Cms::Mocks::DynamicComponents::EmbedBlocks::SectionTitle.generate_data}
    )
  end

  it "should render as SectionTitleWithIconComponent" do
    expect(@comp.render).to be_a(SectionTitleWithIconComponent)
  end
end
