require "rails_helper"

RSpec.describe HubSocialLinkComponent, type: :component do
  it "does not render when value is empty" do
    render_inline(described_class.new(type: "twitter", value: nil))
    expect(page).not_to have_css(".hub-social-link-component")
  end

  context "when type is twitter" do
    it "renders correct image" do
      render_inline(described_class.new(type: "twitter", value: "@twithandle"))
      expect(page).to have_xpath(
        '//img[contains(@class, "hub-social-link-component__image")][contains(@alt, "twitter icon")][contains(@src, "packs-test/media/images/social-media/x_grey-")]'
      )
    end

    it "displays link to twitter" do
      render_inline(described_class.new(type: "twitter", value: "@twithandle"))
      expect(page).to have_link("", href: "https://twitter.com/@twithandle")
    end
  end

  context "when type is x" do
    it "renders correct image" do
      render_inline(described_class.new(type: "x", value: "@twithandle"))
      expect(page).to have_xpath(
        '//img[contains(@class, "hub-social-link-component__image")][contains(@alt, "x icon")][contains(@src, "packs-test/media/images/social-media/x_grey-")]'
      )
    end

    it "displays link to twitter" do
      render_inline(described_class.new(type: "x", value: "@twithandle"))
      expect(page).to have_link("", href: "https://twitter.com/@twithandle")
    end
  end

  context "when type is facebook" do
    it "renders correct image" do
      render_inline(described_class.new(type: "facebook", value: "facehandle"))
      expect(page).to have_xpath(
        '//img[contains(@class, "hub-social-link-component__image")][contains(@alt, "facebook icon")][contains(@src, "packs-test/media/images/social-media/facebook-")]'
      )
    end

    it "displays link to facebook" do
      render_inline(described_class.new(type: "facebook", value: "facehandle"))
      expect(page).to have_link("", href: "https://facebook.com/facehandle")
    end
  end

  context "when type is website" do
    it "renders correct image" do
      render_inline(described_class.new(type: "website", value: "https://www.example.com"))
      expect(page).to have_xpath(
        '//img[contains(@class, "hub-social-link-component__image")][contains(@alt, "website icon")][contains(@src, "packs-test/media/images/social-media/website-")]'
      )
    end

    it "displays link to website" do
      render_inline(described_class.new(type: "website", value: "https://www.example.com"))
      expect(page).to have_link("", href: "https://www.example.com")
    end
  end

  context "when type is linkedin" do
    it "renders correct image" do
      render_inline(described_class.new(type: "linkedin", value: "https://linkedin.com"))
      expect(page).to have_xpath(
        '//img[contains(@class, "hub-social-link-component__image")][contains(@alt, "linkedin icon")][contains(@src, "packs-test/media/images/social-media/linkedin-")]'
      )
    end

    it "displays link to linkedin" do
      render_inline(described_class.new(type: "linkedin", value: "https://linkedin.com"))
      expect(page).to have_link("", href: "https://linkedin.com")
    end
  end
end
