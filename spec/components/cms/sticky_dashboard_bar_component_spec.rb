# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::StickyDashboardBarComponent, type: :component do
  let!(:programme) { create(:primary_certificate) }
  let(:unenrolled_user) { create(:user) }
  let(:enrolled_user) {
    user = create(:user)
    create(:user_programme_enrolment, user:, programme:)
    user
  }

  context "User not logged in" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      render_inline(described_class.new(
        programme_slug: programme.slug
      ))
    end

    it "should not render" do
      expect(page).not_to have_css(".sticky-dashboard-bar-wrapper")
    end
  end

  context "user logged in but not enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(unenrolled_user)
      render_inline(described_class.new(
        programme_slug: programme.slug
      ))
    end

    it "should not render" do
      expect(page).not_to have_css(".sticky-dashboard-bar-wrapper")
    end
  end

  context "user logged in and enrolled" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(enrolled_user)
      render_inline(described_class.new(
        programme_slug: programme.slug
      ))
    end

    it "should render" do
      expect(page).to have_css(".sticky-dashboard-bar-wrapper")
    end

    it "should have link to dashboard" do
      expect(page).to have_link("Take me to my dashboard", href: programme.path)
    end
  end
end
