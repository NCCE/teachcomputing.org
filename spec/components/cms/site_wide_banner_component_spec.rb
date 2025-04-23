require "rails_helper"

RSpec.describe Cms::SiteWideBannerComponent, type: :component do
  context "with banner present" do
    let(:current_notification) { Cms::Collections::SiteWideBanner.all_records.first }

    before do
      stub_strapi_site_wide_banner
      render_inline(described_class.new(current_notification:))
    end

    it "renders the component" do
      expect(page).to have_css(".cms-site-wide-banner-component")
    end

    it "renders the text" do
      expect(page).to have_css("span")
    end
  end

  context "when no banner present" do
    before do
      render_inline(described_class.new(current_notification: nil))
    end

    it "does not render the component" do
      expect(page).to_not have_css(".cms-site-wide-banner-component")
    end
  end
end
