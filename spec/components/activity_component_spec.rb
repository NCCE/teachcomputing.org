require "rails_helper"

RSpec.describe ActivityComponent, type: :component do
  describe "with no extra params" do
    before do
      render_inline(
        described_class.new(
          objective: "I object to things",
          button: {
            text: "Click me",
            path: "https://example.com/thing",
            tracking_label: "clicky thing"
          },
          description: "This component is under construction",
          class_name: "custom_css_class",
          tracking_category: "some category"
        )
      )
    end

    it "renders with the expected objective" do
      expect(page).to have_css(".activity-component__objective-text", text: "I object to things")
    end

    it "renders with the expected description" do
      expect(page).to have_css(".activity-component__description", text: "This component is under construction")
    end

    it "renders the expected link" do
      expect(page).to have_link("Click me", href: "https://example.com/thing")
    end

    it "renders the expected tracking data" do
      link = page.find("a", text: "Click me")
      expect(link["data-event-label"]).to eq("clicky thing")
      expect(link["data-event-category"]).to eq("some category")
    end

    it "renders the custom class" do
      expect(page).to have_css(".custom_css_class")
    end
  end

  describe "with variations on params" do
    before do
      render_inline(
        described_class.new(
          objective: "I object to things",
          button: {
            text: "Click me",
            path: "https://example.com/thing",
            tracking_label: "clicky thing",
            opts: {method: :post}
          },
          class_name: "custom_css_class",
          tracking_category: "some category"
        )
      )
    end

    it "adds an extra button option" do
      link = page.find("a", text: "Click me")
      expect(link["data-method"]).to eq("post")
    end

    it "does not show a description" do
      expect(page).not_to have_css(".activity-component__description")
    end
  end
end
