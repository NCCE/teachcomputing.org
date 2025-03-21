require "rails_helper"

RSpec.describe("cms/blog", type: :view) do
  before do
    stub_strapi_header
    stub_strapi_blog_collection
    assign(:collection, Cms::Collections::Blog.all(1, 50))
    assign(:title, "Page title")
    assign(:collection_wrapper_class, "ncce-news-archive")
    assign(:path, cms_posts_path)
    assign(:page_name, "Articles")
    assign(:wrapper_class, "cms-blogs")
    render template: "cms/collection", layout: "layouts/application"
  end

  it "should have a title" do
    expect(rendered).to have_title("Page Title - Teach Computing")
  end

  it "should have a heading" do
    expect(rendered).to have_css("h1", text: "Page Title")
  end

  it "should add resource_key as class to main tag" do
    expect(rendered).to have_css("main.cms-blogs")
  end
end
