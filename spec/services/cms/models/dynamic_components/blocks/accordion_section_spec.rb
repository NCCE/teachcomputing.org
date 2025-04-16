require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::AccordionSection do
  before do
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::AccordionSection.generate_raw_data
    )
  end

  it "should render as Cms::AccordionSectionComponent" do
    expect(@comp.render).to be_a(Cms::AccordionSectionComponent)
  end
end
