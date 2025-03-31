require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::TestimonialRow do
  before do
    @testimonial_row = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::TestimonialRow.generate_raw_data)
  end

  it "should render as CmsTestimonialRowComponent" do
    expect(@testimonial_row.render).to be_a(Cms::TestimonialRowComponent)
  end
end
