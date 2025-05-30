require "rails_helper"

RSpec.describe("components/_footer", type: :view) do
  before do
    stub_strapi_footer
    assign(:cms_footer, Cms::Singles::Footer.get)
  end

  it "renders the footer component" do
    render
    expect(rendered).to have_css(".cms-footer-component")
  end
end
