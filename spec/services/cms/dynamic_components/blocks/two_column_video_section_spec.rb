require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::TwoColumnVideoSection do
  before do
    @section = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::TwoColumnVideoSection.generate_raw_data(
        video: Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.generate_raw_data
      )
    )
  end

  it "should render as TwoColumnVideoSectionComponent" do
    expect(@section.render).to be_a(Cms::TwoColumnVideoSectionComponent)
  end
end
