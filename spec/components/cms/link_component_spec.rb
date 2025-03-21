# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::LinkComponent, type: :component do
  before do
    render_inline(described_class.new(
      url: "https://www.google.com",
      link_text: "Link to google"
    ))
  end

  it "should render a link" do
    expect(page).to have_link("Link to google", href: "https://www.google.com")
  end
end
