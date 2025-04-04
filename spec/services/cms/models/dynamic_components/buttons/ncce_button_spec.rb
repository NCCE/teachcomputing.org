require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Buttons::NcceButton do
  before do
    @button = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Buttons::NcceButton.generate_raw_data
    )
  end

  it "should render as CmsNcceButtonComponent" do
    expect(@button.render).to be_a(Cms::NcceButtonComponent)
  end
end
