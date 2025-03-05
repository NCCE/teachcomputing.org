require "rails_helper"
require "axe/rspec"

RSpec.describe("Resource Page", type: [:system]) do
  before do
    stub_strapi_blog_post("testing", blog: Cms::Mocks::Blog.generate_raw_data(
        slug: "testing",
        title: "Test blog"
      ))
    visit cms_post_path("testing")
  end

  it "is the correct page" do
    expect(page).to have_content("Test blog")
  end

  it "adds the resource key and id as class to main" do
    expect(page).to have_css("main.cms-blogs-testing")
  end
end
