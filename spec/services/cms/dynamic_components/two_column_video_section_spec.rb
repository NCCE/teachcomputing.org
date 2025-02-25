require "rails_helper"

RSpec.describe Cms::DynamicComponents::TwoColumnVideoSection do
  let(:video_url) { "https://static.teachcomputing.org/How_important_is_the_I_Belong_programme.mp4" }

  before do
    @section = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::TwoColumnVideoSection.generate_raw_data(
        video: Cms::Mocks::DynamicComponents::EmbeddedVideo.generate_raw_data(url: video_url)
      )
    )
  end

  it "should render as TwoColumnVideoSectionComponent" do
    expect(@section.render).to be_a(Cms::TwoColumnVideoSectionComponent)
  end
end
