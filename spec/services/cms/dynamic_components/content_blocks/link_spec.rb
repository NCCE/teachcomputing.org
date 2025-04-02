require "rails_helper"

RSpec.describe Cms::DynamicComponents::ContentBlocks::Link do
  before do
    @link = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::ContentBlocks::Link.generate_raw_data
    )
  end

  it "should render as Cms::LinkComponent" do
    expect(@link.render).to be_a(Cms::LinkComponent)
  end
end
