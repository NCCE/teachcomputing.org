require "rails_helper"

RSpec.describe("pages/terms-conditions", type: :view) do
  let(:user) { create(:user) }

  it "has a title" do
    render
    expect(rendered).to have_css(".govuk-heading-l", text: "National Centre for Computing Education Terms and Conditions")
  end

  it "has 8 sections" do
    render
    expect(rendered).to have_css(".govuk-heading-m", count: 8)
  end
end
