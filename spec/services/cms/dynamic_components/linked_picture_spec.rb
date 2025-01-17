require "rails_helper"

RSpec.describe Cms::DynamicComponents::LinkedPicture do
  before do
    @linked_picture = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::LinkedPicture.generate_raw_data)
  end

  it "should render as CmsImageComponent" do
    expect(@linked_picture.render).to be_a(Cms::ImageComponent)
  end
end
