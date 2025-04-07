require "rails_helper"

RSpec.describe Cms::Models::Images::FeaturedImage do
  it "should render a FeaturedImageComponent" do
    @comp = Cms::Providers::Strapi::Factories::ModelFactory.process_model(
      {model: Cms::Models::Images::FeaturedImage, key: :featuredImage},
      {featuredImage: {data: Cms::Mocks::Images::Image.generate_raw_data}}
    )
    expect(@comp.render).to be_instance_of(FeaturedImageComponent)
  end
end
