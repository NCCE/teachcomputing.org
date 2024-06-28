require "rails_helper"

describe "CMS Page routes" do
  it "has a route for refreshing pages" do
    expect(get("/qwerty/refresh"))
      .to route_to(
        controller: "cms",
        action: "clear_page_cache",
        page_slug: "qwerty"
      )
  end

  it "has a route for refreshing blog pages" do
    expect(get("/blog/asdf/refresh"))
      .to route_to(
        controller: "cms",
        action: "clear_blog_cache",
        page_slug: "asdf"
      )
  end
end
