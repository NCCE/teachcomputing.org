require "rails_helper"

RSpec.describe("layouts/application", type: :view) do
  before do
    render
  end

  it "has a meta description" do
    expect(rendered).to have_css('meta[name="description"]', visible: false)
  end

  it "has correct meta charset" do
    expect(rendered).to have_css('meta[charset="utf-8"]', visible: false)
  end

  it "has correct user-agent support" do
    expect(rendered).to have_css('meta[http-equiv="X-UA-Compatible"][content="IE=Edge,chrome=1"]', visible: false)
  end

  # Possible scope for making these more specific with something like:
  # https://github.com/spree/spree/blob/master/core/lib/spree/testing_support/capybara_ext.rb#L151-L164
  it "has correct number of Open Graph meta tags" do
    expect(rendered).to have_xpath('//meta[starts-with(@property, "og:")]', visible: false, count: 7)
  end

  it "has correct number of Twitter meta tags" do
    expect(rendered).to have_xpath('//meta[starts-with(@name, "twitter:")]', visible: false, count: 7)
  end

  it "has a skip to content link" do
    expect(rendered).to have_link("Skip to main content", href: "#main-content")
  end
end
