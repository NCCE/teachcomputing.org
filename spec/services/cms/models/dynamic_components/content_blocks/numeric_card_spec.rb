require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::ContentBlocks::NumericCard do
  before do
    @numeric_card = Cms::Providers::Strapi::Factories::BlocksFactory.to_numeric_card_array(
      Array.wrap(Cms::Mocks::DynamicComponents::ContentBlocks::NumericCard.generate_data)
    ).first
  end

  it "should render as CmsNumericCardComponent" do
    expect(@numeric_card.render).to be_a(Cms::NumericCardComponent)
  end
end
