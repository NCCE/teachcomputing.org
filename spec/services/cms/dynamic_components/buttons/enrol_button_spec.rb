require "rails_helper"

RSpec.describe Cms::DynamicComponents::Buttons::EnrolButton do
  before do
    @button = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::DynamicComponents::Buttons::EnrolButton.generate_raw_data)
  end

  it "should render as EnrolmentConfirmationComponent" do
    expect(@button.render).to be_a(EnrolmentConfirmationComponent)
  end
end
