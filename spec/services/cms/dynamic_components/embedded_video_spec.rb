require "rails_helper"

RSpec.describe Cms::DynamicComponents::EmbeddedVideo do
  before do
    @video = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::EmbeddedVideo.generate_raw_data
    )
  end

  it "should render as EmbeddedVideoComponent" do
    expect(@video.render).to be_a(Cms::EmbeddedVideoComponent)
  end
end
