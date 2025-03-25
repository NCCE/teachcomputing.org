require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::FeedbackBanner do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::FeedbackBanner.generate_raw_data
    )
  end

  it "should render as Cms::FeedbackBannerComponent" do
    expect(@comp.render).to be_a(Cms::FeedbackBannerComponent)
  end
end
