require "rails_helper"

RSpec.describe Cms::DynamicComponents::EmbeddedVideo do
  let(:video_url) { "https://static.teachcomputing.org/How_important_is_the_I_Belong_programme.mp4" }

  before do
    @video = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::EmbeddedVideo.generate_raw_data(url: video_url)
    )
  end

  it "should render as EmbeddedVideoComponent" do
    expect(@video.render).to be_a(Cms::EmbeddedVideoComponent)
  end
end
