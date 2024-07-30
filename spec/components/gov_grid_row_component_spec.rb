require "rails_helper"

RSpec.describe GovGridRowComponent, type: :component do
  before do
    component = described_class.new.tap do |c|
      c.with_column("full") do
        "Some text"
      end
    end
    render_inline(component)
  end

  it "should render wrapper html" do
    expect(page).to have_css(".govuk-width-container")
    expect(page).to have_css(".govuk-main-wrapper")
    expect(page).to have_css(".govuk-grid-row")
  end

  it "should render column class" do
    expect(page).to have_css(".govuk-grid-column-full")
  end

  context "with background color" do
    before do
      component = described_class.new(
        background_color: "purple"
      ).tap do |c|
        c.with_column("full", padding: {top: 2}, margin: {left: 1}) do
          "Some text"
        end
      end
      render_inline(component)
    end

    it "should add the correct class" do
      expect(page).to have_css(".purple-bg.tc-gov-grid-wrapper")
    end
  end

  context "with padding and margin" do
    before do
      component = described_class.new(
        padding: {right: 5},
        margin: {bottom: 4}
      ).tap do |c|
        c.with_column("full", padding: {top: 2}, margin: {left: 1}) do
          "Some text"
        end
      end
      render_inline(component)
    end

    it "should add padding class" do
      expect(page).to have_css("div.govuk-main-wrapper[class*='padding-right-5']")
      expect(page).to have_css("div.govuk-grid-column-full[class*='padding-top-2']")
    end

    it "should add margin class" do
      expect(page).to have_css("div.govuk-main-wrapper[class*='margin-bottom-4']")
      expect(page).to have_css("div.govuk-grid-column-full[class*='margin-left-1']")
    end
  end
end
