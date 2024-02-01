require "rails_helper"

RSpec.describe("pages/signup-confirmation", type: :view) do
  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_css(".govuk-heading-xl", text: "Thank you!")
  end

  it "has a link back to the root path" do
    expect(rendered).to have_link("Return to the site", href: root_path)
  end
end
