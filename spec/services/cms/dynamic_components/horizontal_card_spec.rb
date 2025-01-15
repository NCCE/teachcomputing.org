require "rails_helper"

RSpec.describe Cms::DynamicComponents::HorizontalCard do
  before do
    @card = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::HorizontalCard.generate_raw_data)
  end

  it "should render as CmsHorizontalCardComponent" do
    expect(@card.render).to be_a(CmsHorizontalCardComponent)
  end
end
