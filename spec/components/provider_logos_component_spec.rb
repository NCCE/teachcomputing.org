require "rails_helper"

RSpec.describe ProviderLogosComponent, type: :component do
  context "outside dashboard" do
    let(:data) do
      {
        dashboard: false,
        class_name: "custom-class"
      }
    end

    before do
      render_inline(described_class.new(**data))
    end

    it "adds the wrapper class" do
      expect(page).to have_css(".custom-class")
    end

    it "does not add the dashboard modifier" do
      expect(page).not_to have_css(".provider-logos-component--dashboard")
    end

    it "falls back to stem-learning copy" do
      expect(page).to have_text("This course is from the National Centre for Computing Education and is delivered by STEM Learning.")
    end

    it "has the expected logos" do
      expect(page).to have_css("img[src*='ncce-logo']")
      expect(page).to have_css("img[src*='stem-logo-small']")
    end
  end

  context "when provider is not stem-learning" do
    let(:data) do
      {
        provider: "future-learn",
        dashboard: false,
        class_name: "custom-class"
      }
    end

    before do
      render_inline(described_class.new(**data))
    end

    it "uses the text for the retired Raspberry Pi/FutureLearn online courses" do
      expect(page).to have_text("This course is from Teach Computing and delivered by Raspberry Pi Foundation.")
    end

    it "does not display logos" do
      expect(page).not_to have_css("img")
    end
  end

  context "on the dashboard" do
    let(:data) do
      {
        dashboard: true,
        class_name: "custom-class"
      }
    end

    before do
      render_inline(described_class.new(**data))
    end

    it "adds the modifier" do
      expect(page).to have_css(".provider-logos-component--dashboard")
    end
  end

  context "when provider is stem-learning" do
    let(:data) do
      {
        provider: "stem-learning",
        dashboard: false,
        class_name: "custom-class"
      }
    end

    before do
      render_inline(described_class.new(**data))
    end

    it "shows the stem-learning copy" do
      expect(page).to have_text("This course is from the National Centre for Computing Education and is delivered by STEM Learning.")
    end

    it "has the expected logos" do
      expect(page).to have_css("img[src*='ncce-logo']")
      expect(page).to have_css("img[src*='stem-logo-small']")
    end
  end
end
