require "rails_helper"

RSpec.describe("pages/exception", type: :view) do
  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_css(".govuk-heading-xl", text: "Page not found")
  end
end
