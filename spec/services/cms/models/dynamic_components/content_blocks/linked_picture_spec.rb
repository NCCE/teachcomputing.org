require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::ContentBlocks::LinkedPicture do
  before do
    @linked_picture = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::ContentBlocks::LinkedPicture.generate_raw_data
    )
  end

  it "should render as CmsImageComponent" do
    expect(@linked_picture.render).to be_a(Cms::ImageComponent)
  end
end
