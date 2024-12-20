require "rails_helper"

RSpec.describe Cms::DynamicComponents::EnrolmentSplitCourseCard do
  let(:enrol_aside_slug) { "enrol-split-card-factory-test" }
  before do
    stub_strapi_aside_section(enrol_aside_slug)
    @card = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::EnrolmentSplitCourseCard.generate_raw_data(
        enrol_aside: {data: [{attributes: {slug: enrol_aside_slug}}]}
      )
    )
  end

  it "should render as Cms::EnrolmentSplitCourseCardComponent" do
    expect(@card.render).to be_a(Cms::EnrolmentSplitCourseCardComponent)
  end
end
