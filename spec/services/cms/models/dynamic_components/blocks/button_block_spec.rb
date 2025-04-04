require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::ButtonBlock do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::ButtonBlock.generate_raw_data
    )
  end

  it "should render as Cms::ButtonBlockComponent" do
    expect(@comp.render).to be_a(Cms::ButtonBlockComponent)
  end
end
