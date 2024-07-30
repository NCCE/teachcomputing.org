require "rails_helper"

RSpec.describe BannerWithBackgroundComponent, type: :component do
  context "when a label is provided" do
    before do
      render_inline(described_class.new(
        background_image_css: "background_image_css",
        label: {
          title: "A title",
          body: "A body"
        }
      ))
    end

    it "should render the label" do
      expect(page).to have_css(".govuk-body-s", text: "A body")
    end
  end

  context "when no label is provided" do
    before do
      render_inline(described_class.new(
        background_image_css: "background_image_css"
      ))
    end

    it "should render the label" do
      expect(page).not_to have_css(".govuk-body-s", text: "A body")
    end
  end
end
