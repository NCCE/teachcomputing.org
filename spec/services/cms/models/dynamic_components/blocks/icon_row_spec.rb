require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::IconRow do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::IconRow.generate_raw_data
    )
  end

  it "should render as Cms::IconRowComponent" do
    expect(@comp.render).to be_a(Cms::IconRowComponent)
  end
end
