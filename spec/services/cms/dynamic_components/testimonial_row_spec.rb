require "rails_helper"

RSpec.describe Cms::DynamicComponents::TestimonialRow do
  before do
    @testimonial_row = Cms::Providers::Strapi::Factories::ComponentFactory.to_testimonial_row(Cms::Mocks::TestimonialRow.generate_data)
  end

  it "should render as CmsFullWidthBannerComponent" do
    expect(@testimonial_row.render).to be_a(CmsTestimonialRowComponent)
  end
end
