require "rails_helper"

RSpec.describe("pages/home/index", type: :view) do
  context "has featured posts" do
    before do
      stub_featured_posts
      render
    end

    # it("renders the featured news section") do
    #  expect(rendered).to(have_css(".ncce-feat", count: 1))
    # end
  end
end
