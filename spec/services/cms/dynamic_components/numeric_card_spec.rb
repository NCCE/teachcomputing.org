require "rails_helper"

RSpec.describe Cms::DynamicComponents::NumericCard do
  before do
    @numeric_card = Cms::Providers::Strapi::Factories::ComponentFactory.numeric_card_block(Cms::Mocks::NumericCard.generate_data)
  end

  it "should render as CmsNumericCardComponent" do
    expect(@numeric_card.render).to be_a(CmsNumericCardComponent)
  end
end
