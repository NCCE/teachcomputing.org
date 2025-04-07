require "rails_helper"

RSpec.describe Cms::Models::Collections::BlogPreview do
  it "should render a BlogPreviewComponent" do
    @comp = Cms::Providers::Strapi::Factories::ModelFactory.process_model(
      {model: Cms::Models::Collections::BlogPreview, key: nil},
      Cms::Mocks::Collections::BlogPreview.generate_data
    )
    expect(@comp.render).to be_instance_of(BlogPreviewComponent)
  end
end
