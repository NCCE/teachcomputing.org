require "rails_helper"

RSpec.describe Cms::DynamicComponents::SplitHorizontalCard do
  before do
    @card = Cms::Providers::Strapi::Factories::ComponentFactory.to_split_horizontal_card(Cms::Mocks::SplitHorizontalCard.generate_data)
  end

  it "should render as CmsSplitHorizontalCardComponent" do
    expect(@card.render).to be_a(CmsSplitHorizontalCardComponent)
  end
end
