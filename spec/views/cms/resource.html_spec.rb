require "rails_helper"

RSpec.describe("cms/resource", type: :view) do
  before do
    stub_strapi_header
    stub_strapi_blog_post("test-blog", blog: Cms::Mocks::BlogComponents::Blog.generate_raw_data(
      slug: "test-blog",
      seo: Cms::Mocks::MetaComponents::Seo.generate_data(title: "some SEO content", description: "testing")
    ))
    @resource = Cms::Collections::Blog.get("test-blog")
    assign(:wrapper_class, "cms-blogs-test-blog")
    render template: "cms/resource", layout: "layouts/application"
  end

  describe "meta data" do
    it "should render title" do
      expect(rendered).to have_title("some SEO content")
    end

    it "should render description" do
      expect(rendered).to have_selector("meta[name='description'][content='testing']", visible: false)
    end

    it "should add resource_key as class to main tag" do
      expect(rendered).to have_css("main.cms-blogs-test-blog")
    end
  end
end
