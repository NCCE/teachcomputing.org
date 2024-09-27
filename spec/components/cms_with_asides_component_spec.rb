require "rails_helper"

RSpec.describe CmsWithAsidesComponent, type: :component do
  context "with valid aside" do
    before do
      stub_strapi_aside_section("test-aside")
      render_inline(described_class.new(aside_sections: [{slug: "test-aside"}]))
    end

    it "should display aside section" do
      expect(page).to have_css(".aside-component")
    end
  end

  context "with multiple asides" do
    before do
      stub_strapi_aside_section("test-aside")
      render_inline(described_class.new(aside_sections: [{slug: "test-aside"}, {slug: "test-aside-2"}]))
    end

    it "should display aside section" do
      expect(page).to have_css(".aside-component", count: 2)
    end
  end

  context "missing aside" do
    before do
      stub_strapi_aside_section_missing("missing-aside")
      puts "Im here"
      render_inline(described_class.new(aside_sections: [{slug: "missing-aside"}]))
    end

    it "should display aside section" do
      expect(page).not_to have_css(".aside-component")
    end
  end
end
