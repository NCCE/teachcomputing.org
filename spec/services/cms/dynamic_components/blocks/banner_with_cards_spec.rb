require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::BannerWithCards do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::DynamicComponents::Blocks::BannerWithCards.generate_raw_data)
  end

  it "should render as BannerWithCardsComponent" do
    expect(@comp.render).to be_a(Cms::BannerWithCardsComponent)
  end
end
