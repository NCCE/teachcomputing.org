require "rails_helper"

RSpec.describe Cms::DynamicComponents::ContentBlocks::LinkWithIcon do
  before do
    @link = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::ContentBlocks::LinkWithIcon.generate_raw_data
    )
  end

  it "should render as Cms::LinkWithIconComponent" do
    expect(@link.render).to be_a(Cms::LinkWithIconComponent)
  end
end
