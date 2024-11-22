require "rails_helper"

RSpec.describe Cms::DynamicComponents::EnrolmentTestimonial do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::DynamicComponents::EnrolmentTestimonial.generate_raw_data)
  end

  it "should render as Cms::EnrolmentTestimonialComponent" do
    expect(@comp.render).to be_a(Cms::EnrolmentTestimonialComponent)
  end
end
