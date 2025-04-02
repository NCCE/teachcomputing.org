require "rails_helper"

RSpec.describe Cms::DynamicComponents::MultiStateLink do
  before do
    @links = Cms::Mocks::DynamicComponents::MultiStateLink.as_model
  end

  it "should render as CmsMultiStateLinkComponent" do
    expect(@links.render).to be_a(Cms::MultiStateLinkComponent)
  end
end
