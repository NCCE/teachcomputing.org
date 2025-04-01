require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::HorizontalCard do
  before do
    @card = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::HorizontalCard.generate_raw_data
    )
  end

  it "should render as HorizontalCardComponent" do
    expect(@card.render).to be_a(Cms::HorizontalCardComponent)
  end
end
