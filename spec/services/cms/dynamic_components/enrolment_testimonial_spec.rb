require "rails_helper"

RSpec.describe Cms::DynamicComponents::EnrolmentTestimonial do
  let(:enrolled_aside_slug) { "enrolment-testimonial-factory-test" }
  let(:enrol_aside_slug) { "enrol-testimonial-factory-test" }
  before do
    stub_strapi_aside_section(enrolled_aside_slug)
    stub_strapi_aside_section(enrol_aside_slug)
    data = Cms::Mocks::DynamicComponents::EnrolmentTestimonial.generate_raw_data(
      enrol_aside: {data: [{attributes: {slug: enrol_aside_slug}}]},
      enrolled_aside: {data: [{attributes: {slug: enrolled_aside_slug}}]}
    )
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(data)
  end

  it "should render as Cms::EnrolmentTestimonialComponent" do
    expect(@comp.render).to be_a(Cms::EnrolmentTestimonialComponent)
  end
end
