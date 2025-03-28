require "rails_helper"

RSpec.describe IBelongFlagComponent, type: :component do
  context "with label" do
    before do
      render_inline(described_class.new(label: true))
    end

    it "should render the label tooltip classes" do
      expect(page).to have_css(".i-belong__label.tooltip")
    end

    it "should render the tooltip" do
      expect(page).to have_css(".tooltiptext", text: /I Belong:/)
    end
  end

  context "without label" do
    before do
      render_inline(described_class.new)
    end

    it "should render the label tooltip classes" do
      expect(page).to have_css(".i-belong-flag")
    end

    it "should render the tooltip" do
      expect(page).to have_css(".tooltiptext", text: /I Belong:/)
    end
  end
end
