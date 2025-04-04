require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::TwoColumnPictureSection do
  before do
    @section = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::TwoColumnPictureSection.generate_raw_data
    )
  end

  it "should render as TwoColumnPictureSectionComponent" do
    expect(@section.render).to be_a(Cms::TwoColumnPictureSectionComponent)
  end
end
