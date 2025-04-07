require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::ContentBlocks::FileLink do
  before do
    @link = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::ContentBlocks::FileLink.generate_raw_data
    )
  end

  it "should render as Cms::FileLinkComponent" do
    expect(@link.render).to be_a(Cms::FileComponent)
  end
end
