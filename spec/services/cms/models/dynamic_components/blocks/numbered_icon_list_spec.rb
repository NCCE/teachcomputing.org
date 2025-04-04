require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::NumberedIconList do
  before do
    @icon_list = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::NumberedIconList.generate_raw_data
    )
  end

  it "should render as CmsNumberedIconListComponent" do
    expect(@icon_list.render).to be_a(Cms::NumberedIconListComponent)
  end
end
