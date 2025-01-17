require "rails_helper"

RSpec.describe Cms::DynamicComponents::NcceButton do
  before do
    @button = Cms::Providers::Strapi::Factories::ComponentFactory.to_ncce_button(Cms::Mocks::NcceButton.generate_data)
  end

  it "should render as CmsNcceButtonComponent" do
    expect(@button.render).to be_a(Cms::NcceButtonComponent)
  end
end
