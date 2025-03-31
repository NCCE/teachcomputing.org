require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::CardWrapper do
  before do
    card_section_data = Cms::Mocks::NumericCardSection.generate_data
    @card_wrapper = Cms::Providers::Strapi::Factories::BlocksFactory.to_card_wrapper(card_section_data, card_section_data[:numericCards])
  end

  it "should render as CmsCardWrapperComponent" do
    expect(@card_wrapper.render).to be_a(Cms::CardWrapperComponent)
  end
end
