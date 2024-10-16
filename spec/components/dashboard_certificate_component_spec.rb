# frozen_string_literal: true

require "rails_helper"

RSpec.describe DashboardCertificateComponent, type: :component do
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:i_belong) { create(:i_belong) }

  context "with an individual achievement" do
    before do
      render_inline(described_class.new(
        certificate: primary_certificate,
        button_text: "Check my progress",
        button_color: "ncce-button"
      ))
    end

    it "renders the correct certficiate name" do
      expect(page).to have_css("h2", text: primary_certificate.dashboard_name)
    end

    it "has the correct button text" do
      expect(page).to have_css("a", text: "Check my progress")
    end

    it "has the correct button colour" do
      expect(page).to have_css(".ncce-button")
    end

    it "has the correct ribbon colour for primary certificate" do
      expect(page).to have_css(".dashboard-certificate--green-ribbon")
    end

    it "has the individual achievement icon" do
      expect(page).to have_css(".dashboard-certificate__icon--individual")
    end

    it "has the individual achievement tooltip" do
      expect(page).to have_css(".tooltiptext", text: "Individual achievement")
    end
  end

  context "with a school achievement" do
    before do
      render_inline(described_class.new(
        certificate: i_belong,
        button_text: "Check my progress",
        button_color: "ncce-button"
      ))
    end

    it "renders the correct certficiate name" do
      expect(page).to have_css("h2", text: i_belong.dashboard_name)
    end

    it "has the correct ribbon colour for I belong certificate" do
      expect(page).to have_css(".dashboard-certificate--orange-ribbon")
    end

    it "has the individual achievement icon" do
      expect(page).to have_css(".dashboard-certificate__icon--school")
    end

    it "has the individual achievement tooltip" do
      expect(page).to have_css(".tooltiptext", text: "School achievement")
    end
  end
end
