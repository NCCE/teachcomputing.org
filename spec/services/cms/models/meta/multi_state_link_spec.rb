require "rails_helper"

RSpec.describe Cms::Models::Meta::MultiStateLink do
  before do
    @links = Cms::Mocks::Meta::MultiStateLink.as_model
  end

  it "should render as CmsMultiStateLinkComponent" do
    expect(@links.render).to be_a(Cms::MultiStateLinkComponent)
  end
end
