require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::SharedFields do
  describe "#programme_slug" do
    it "should default name to programme" do
      expect(described_class.programme_slug).to match(/^\w*programme\s*{/)
    end

    it "should include slug field" do
      expect(described_class.programme_slug).to match(/programme\s*{\s*slug\s*}/)
    end

    it "should use provided name" do
      expect(described_class.programme_slug("test")).to match(/^\w*test\s*{/)
    end
  end

  describe "#icon_block" do
    it "should return valid query" do
      expect(described_class.icon_block("iconBlock")).to match(/iconBlock\s*{\s*iconText\s*iconImage/)
    end
  end

  describe "#color_theme" do
    it "should return valid query" do
      expect(described_class.color_theme("color")).to match(/color\s*{\s*name\s*}/)
    end
  end

  describe "#aside_sections" do
    it "should return valid query" do
      expect(described_class.aside_sections).to match(/asideSections\s*{\s*slug\s*}/)
    end

    it "should return valid query with provided name" do
      expect(described_class.aside_sections("test")).to match(/test\s*{\s*slug\s*}/)
    end
  end

  describe "#image_fields" do
    it "should return valid query" do
      expect(described_class.image_fields("image")).to match(/^\w*image\s*{/)
    end

    it "should include main fields" do
      expect(described_class.image_fields("image")).to include("alternativeText")
      expect(described_class.image_fields("image")).to include("caption")
      expect(described_class.image_fields("image")).to include("url")
      expect(described_class.image_fields("image")).to include("formats")
    end
  end
end
