require "rails_helper"

RSpec.describe HeroMediaComponent, type: :component do
  let(:data) do
    {
      class_name: "dixie-bg",
      title: "About us",
      text: "This is example text"
    }
  end

  describe "when a video is passed" do
    before do
      data[:video] = {
        url: "https://www.youtube.com/embed/hPpAB-g_9Kc",
        page: "A Page",
        label: "Some video"
      }
      render_inline(described_class.new(**data))
    end

    it "adds the wrapper class" do
      expect(page).to have_css(".dixie-bg")
    end

    it "renders the title" do
      expect(page).to have_css(".hero-media-component__title", text: "About us")
    end

    it "renders the body text" do
      expect(page).to have_css(".hero-media-component__text", text: "This is example text")
    end

    it "renders a video" do
      expect(page).to have_css(".hero-media-component__media iframe")
      expect(page).to have_css("iframe[src*='hPpAB-g_9Kc']")
    end
  end

  describe "when an image is passed" do
    before do
      data[:image] = {
        url: "media/images/landing-pages/pri-hero.png",
        title: "Image title"
      }
      render_inline(described_class.new(**data))
    end

    it "renders an image" do
      expect(page).to have_css(".hero-media-component__media img")
      expect(page).to have_css("img[src*='pri-hero']")
    end
  end

  describe "when no media is passed" do
    it "throws an error" do
      expect { render_inline(described_class.new(**data)) }.to raise_error ArgumentError
    end
  end
end
