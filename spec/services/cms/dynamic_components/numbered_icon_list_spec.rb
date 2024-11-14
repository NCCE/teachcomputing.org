require "rails_helper"

RSpec.describe Cms::DynamicComponents::NumberedIconList do
  before do
    @icon_list = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::NumberedIconList.generate_raw_data)
  end

  it "should render as CmsNumberedIconListComponent" do
    expect(@icon_list.render).to be_a(CmsNumberedIconListComponent)
  end
end
