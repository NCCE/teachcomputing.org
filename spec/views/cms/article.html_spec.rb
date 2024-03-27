require "rails_helper"

RSpec.describe("cms/article", type: :view) do
  before do
    stub_cms_page
    @article = Ghost.new.get_single_page("funding")
    render
  end

  it("renders the title") do
    expect(rendered).to have_css(".hero__heading", text: @article["meta_title"])
  end

  it("renders the content") do
    expect(rendered).to have_css(".external-content", text: /This is a test page/)
  end
end
