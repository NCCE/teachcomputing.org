require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::TextWithTestimonial do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::DynamicComponents::Blocks::TextWithTestimonial.generate_raw_data)
  end

  it "should render as Cms::TextWithTestimonial" do
    expect(@comp.render).to be_a(Cms::TextWithTestimonialComponent)
  end
end
