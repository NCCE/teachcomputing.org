require "rails_helper"

RSpec.describe("pages/contributing-partners", type: :view) do
  before do
    render
  end

  it "has a main paragraph" do
    expect(rendered).to have_css(".govuk-body-l", count: 1)
  end

  it "has 11 cards" do
    expect(rendered).to have_css(".image-link-card-component", count: 11)
  end
end
