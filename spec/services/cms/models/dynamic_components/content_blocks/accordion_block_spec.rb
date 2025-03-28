require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::ContentBlocks::AccordionBlock do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::ContentBlocks::AccordionBlock.generate_raw_data
    )
  end

  it "should render as Cms::AccordionBlockComponent" do
    expect(@comp.render(index: 1)).to be_a(Cms::AccordionBlockComponent)
  end
end
