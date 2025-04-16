require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::ContentBlocks::AccordionBlock do
  before do
    @comp = Cms::Providers::Strapi::Factories::BlocksFactory.to_accordion_block_array(
      Array.wrap(Cms::Mocks::DynamicComponents::ContentBlocks::AccordionBlock.generate_raw_data)
    )
  end

  it "should render as Cms::AccordionBlockComponent" do
    expect(@comp.first.render).to be_a(Cms::AccordionBlockComponent)
  end
end
