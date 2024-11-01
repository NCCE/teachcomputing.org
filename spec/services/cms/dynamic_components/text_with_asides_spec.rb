require "rails_helper"

RSpec.describe Cms::DynamicComponents::TextWithAsides do
  before do
    @text = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::TextWithAsides.generate_raw_data)
  end

  it "should render as CmsTextWithAsidesComponent" do
    expect(@text.render).to be_a(CmsTextWithAsidesComponent)
  end
end
