require "rails_helper"

RSpec.describe Cms::DynamicComponents::FullWidthText do
  before do
    @text = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::FullWidthText.generate_raw_data)
  end

  it "should render as CmsFullWidthBannerComponent" do
    expect(@text.render).to be_a(CmsFullWidthTextBlockComponent)
  end
end