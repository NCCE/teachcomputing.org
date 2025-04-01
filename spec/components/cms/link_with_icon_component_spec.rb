# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::LinkWithIconComponent, type: :component do
  before do
    render_inline(described_class.new(
      url: "https://www.google.com",
      link_text: "Link to google",
      icon: Cms::Mocks::ImageComponents::Image.as_model
    ))
  end

  it "should render a link" do
    expect(page).to have_link("Link to google", href: "https://www.google.com")
  end

  it "should have an image" do
    expect(page).to have_css("img")
  end
end
