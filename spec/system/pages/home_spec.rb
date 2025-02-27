require "rails_helper"
require "axe/rspec"

RSpec.describe("Home page", type: :system) do
  before do
    stub_strapi_homepage
    stub_featured_posts
    visit root_path
  end

  it "header is accessible" do
    expect(page).to be_accessible.within("header")
  end

  it "page is accessible" do
    expect(page).to be_accessible.within("#main-content").excluding(".axe-skip-a11y-test")
  end

  it "footer is accessible" do
    expect(page).to be_accessible.within("footer")
  end
end
