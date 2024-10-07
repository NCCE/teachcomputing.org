require "rails_helper"

RSpec.describe Cms::DynamicComponents::HorizontalCard do
  before do
    @card = Cms::Providers::Strapi::Factories::ComponentFactory.to_horizontal_card(Cms::Mocks::HorizontalCard.generate_data)
  end

  it "should render as CmsHorizontalCardComponent" do
    expect(@card.render).to be_a(CmsHorizontalCardComponent)
  end
end
