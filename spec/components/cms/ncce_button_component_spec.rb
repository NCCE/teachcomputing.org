# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::NcceButtonComponent, type: :component do
  context "standard button" do
    before do
      render_inline(described_class.new(
        title: "Click me",
        link: "https://www.teachcomputing.test/click-me",
        color: :white
      ))
    end

    it "should render the link with the correct classes" do
      expect(page).to have_link("Click me", href: "https://www.teachcomputing.test/click-me", class: ["button", "govuk-button", "ncce-button--white"])
    end
  end

  context "button with logged in options" do
    let(:user) { create(:user) }

    context "not logged in" do
      before do
        render_inline(described_class.new(
          title: "Join now",
          link: "/auth/stem",
          color: :white,
          logged_in_title: "View dashboard",
          logged_in_link: "/dashboard"
        ))
      end
      it "should render the link with the correct classes" do
        expect(page).to have_link("Join now", href: "/auth/stem", class: ["button", "govuk-button", "ncce-button--white"])
      end
    end

    context "logged in" do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

        render_inline(described_class.new(
          title: "Join now",
          link: "/auth/stem",
          color: :white,
          logged_in_title: "View dashboard",
          logged_in_link: "/dashboard"
        ))
      end
      it "should render the link with the correct classes" do
        expect(page).to have_link("View dashboard", href: "/dashboard", class: ["button", "govuk-button", "ncce-button--white"])
      end
    end
  end
end
