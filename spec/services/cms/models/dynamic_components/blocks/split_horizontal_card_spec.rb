require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::SplitHorizontalCard do
  before do
    @card = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::SplitHorizontalCard.generate_raw_data
    )
  end

  it "should render as CmsSplitHorizontalCardComponent" do
    expect(@card.render).to be_a(Cms::SplitHorizontalCardComponent)
  end
end
