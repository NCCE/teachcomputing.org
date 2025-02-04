require "rails_helper"

RSpec.describe Cms::EmailComponents::Cta do
  let(:cta_data) {
    Cms::Mocks::EmailComponents::Cta.generate_raw_data(
      text: "Test Link",
      link: "https://www.google.com"
    )
  }

  before do
    @cta = Cms::Providers::Strapi::Factories::EmailComponentFactory.process_component(cta_data)
  end

  it "should render as NcceButtonComponent" do
    expect(@cta.render(nil, nil)).to be_a(Cms::NcceButtonComponent)
  end

  it "should render text as CtaText" do
    expect(@cta.render_text(nil, nil)).to be_a(Cms::EmailComponents::CtaText)
  end
end
