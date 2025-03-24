require "rails_helper"
require "axe/rspec"

RSpec.describe("Collection Page", type: [:system]) do
  before do
    stub_strapi_blog_collection
    visit cms_posts_path
  end

  it "is the correct page" do
    expect(page).to have_content("News & Updates")
  end

  it "adds the resource key as class to main" do
    expect(page).to have_css("main.cms-blogs")
  end
end
