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

  it "has a route for refreshing nested pages" do
    expect(get("/qwerty/asdf/refresh"))
      .to route_to(
        controller: "cms",
        action: "clear_page_cache",
        parent_slug: "qwerty",
        page_slug: "asdf"
      )
  end
end
