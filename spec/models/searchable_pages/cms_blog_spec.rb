require "rails_helper"

RSpec.describe SearchablePages::CmsBlog, type: :model do
  describe "#url" do
    it "should return a cms_post_path" do
      page = create(:searchable_pages_cms_blog)
      expect(page.url).to eq Rails.application.routes.url_helpers.cms_post_path(page.slug)
    end
  end
end
