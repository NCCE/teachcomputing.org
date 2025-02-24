require "rails_helper"

RSpec.describe("cms/resource", type: :view) do
  before do
    stub_strapi_header
    stub_strapi_get_single_blog_post("blogs/test-blog",
      seo: {
        title: "some SEO content",
        description: "testing"
      })
    @resource = Cms::Collections::Blog.get("test-blog")
    render template: "cms/resource", layout: "layouts/application"
  end

  describe "meta data" do
    it "should render title" do
      expect(rendered).to have_title("some SEO content")
    end

    it "should render description" do
      expect(rendered).to have_selector("meta[name='description'][content='testing']", visible: false)
    end
  end
end
