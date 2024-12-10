require "rails_helper"

RSpec.describe ProgrammeStatusComponent, type: :component do
  let(:programme) { create(:primary_certificate) }

  before do
    stub_strapi_programme(programme.slug, programme: Cms::Mocks::Programme.generate_raw_data(
      status_pending_title: "Pending title",
      status_completed_title: "Completed title"
    ))
  end

  context "Enrolment enrolled" do
    let(:user_programme_enrolment) { create(:user_programme_enrolment, programme:) }

    before do
      render_inline(described_class.new(user_programme_enrolment:))
    end

    it "should not render" do
      expect(page).not_to have_css(".programme-status-wrapper")
    end
  end

  context "Enrolment Pending" do
    let(:user_programme_enrolment) { create(:pending_enrolment, programme:) }

    before do
      render_inline(described_class.new(user_programme_enrolment:))
    end

    it "should render the wrapper" do
      expect(page).to have_css(".programme-status-wrapper")
    end

    it "should render the correct heading" do
      expect(page).to have_css("h2.govuk-heading-m", text: "Pending title")
    end
  end

  context "Enrolment completed" do
    let(:user_programme_enrolment) { create(:completed_enrolment, programme:) }

    before do
      render_inline(described_class.new(user_programme_enrolment:))
    end

    it "should render the wrapper" do
      expect(page).to have_css(".programme-status-wrapper")
    end

    it "should render the correct heading" do
      expect(page).to have_css("h2.govuk-heading-m", text: "Completed title")
    end

    it "should render cerficate button" do
      expect(page).to have_link("Download your certificate", href: "/certificate/primary-certificate/view-certificate")
    end
  end
end
