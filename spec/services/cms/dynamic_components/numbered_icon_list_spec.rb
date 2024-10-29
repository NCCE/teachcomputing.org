require "rails_helper"

RSpec.describe Cms::DynamicComponents::NumberedIconList do
  before do
    @icon_list = Cms::Providers::Strapi::Factories::ComponentFactory.to_numbered_icon_list(Cms::Mocks::NumberedIconList.generate_data)
  end

  it "should render as CmsNcceButtonComponent" do
    expect(@icon_list.render).to be_a(CmsNumberedIconListComponent)
  end
end
