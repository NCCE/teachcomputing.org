require "rails_helper"

RSpec.describe("certificates/cs_accelerator/show", type: :view) do
  let(:user) { create(:user) }
  let!(:programme) { create(:cs_accelerator) }

  before do
    @current_user = user
    @programme = programme
  end

  context "when the user is not on a pathway" do
    before do
      @csa_dash = CSADash.new(user: user)
      render
    end

    it "has the hero" do
      expect(rendered).to have_css(".hero__heading", text: programme.title)
    end

    it "has a heading" do
      expect(rendered).to have_css(".govuk-heading-m")
    end

    it "has an activity heading" do
      expect(rendered).to have_css(".govuk-heading-s")
    end
  end

  context "when the user is on a pathway" do
    let(:pathway) { create(:pathway, programme:) }

    before do
      stub_course_templates
      stub_duration_units
      create_list(:pathway_activity, 4, pathway:)
      create(:user_programme_enrolment, user:, programme:, pathway:)
      @csa_dash = CSADash.new(user: user)
      render
    end

    it "starts with the recommended courses collapsed" do
      expect(rendered).to have_css(".recommended-courses-wrapper button[aria-expanded='false']", text: "Show all 4 courses")
    end
  end
end
