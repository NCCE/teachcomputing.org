require "rails_helper"

RSpec.describe Cms::DynamicComponents::TwoColumnPictureSection do
  before do
    @section = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::TwoColumnPictureSection.generate_raw_data
    )
  end

  it "should render as TwoColumnPictureSectionComponent" do
    expect(@section.render).to be_a(Cms::TwoColumnPictureSectionComponent)
  end
end
