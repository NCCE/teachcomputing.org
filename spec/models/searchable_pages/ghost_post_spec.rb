require "rails_helper"

RSpec.describe SearchablePages::GhostPost, type: :model do
  describe "#url" do
    it "should return a cms_post_path" do
      post = create(:searchable_pages_ghost_post)
      expect(post.url).to eq Rails.application.routes.url_helpers.cms_post_path(post.slug)
    end
  end
end
