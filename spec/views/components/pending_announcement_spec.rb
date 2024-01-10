require "rails_helper"

RSpec.describe("components/_announcement") do
  before do
    render
  end

  it "has a tag" do
    expect(rendered).to have_css(".ncce-announcement__tag", text: "ANNOUNCEMENT")
  end

  it "has the text" do
    expect(rendered).to have_css(".ncce-announcement__copy", text: "")
  end
end
