require "rails_helper"
require "axe/rspec"

RSpec.describe("Resource Page", type: [:system]) do
  let(:slug) { "testing" }
  let(:blog) { Cms::Mocks::Collections::Blog.generate_raw_data(slug:, title: "Test blog") }

  before do
    stub_strapi_blog_post(slug, blog:)
    visit cms_post_path(slug)
  end

  it "is the correct page" do
    expect(page).to have_content("Test blog")
  end

  it "adds the resource key and id as class to main" do
    expect(page).to have_css("main.cms-blogs-testing")
  end
end
