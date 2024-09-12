# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsNcceButtonComponent, type: :component do
  describe "without colour" do
    before do
      render_inline(described_class.new(
        title: "Click me",
        link: "https://www.teachcomputing.test/click-me"
      ))
    end

    it "should render the link with correct classes" do
      expect(page).to have_link("Click me", href: "https://www.teachcomputing.test/click-me", class: ["button", "govuk-button"])
    end
  end

  describe "with colour" do
    before do
      render_inline(described_class.new(
        title: "Click me",
        link: "https://www.teachcomputing.test/click-me",
        colour: :white
      ))
    end

    it "should render the link with the correct classes" do
      expect(page).to have_link("Click me", href: "https://www.teachcomputing.test/click-me", class: ["button", "govuk-button", "ncce-button--white"])
    end
  end
end
