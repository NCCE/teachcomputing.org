require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::HorizontalCardWithAsides do
  before do
    @card = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::HorizontalCardWithAsides.generate_raw_data
    )
  end

  it "should render as HorizontalCardWithAsidesComponent" do
    expect(@card.render).to be_a(Cms::HorizontalCardWithAsidesComponent)
  end
end
