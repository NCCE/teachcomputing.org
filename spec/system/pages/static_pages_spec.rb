require "rails_helper"
require "axe/rspec"

RSpec.describe("Static pages", type: :system) do
  let(:programme) { create(:programme, slug: "subject-knowledge") }

  context "Accessibility statement page" do
    before do
      visit accessibility_statement_path
    end

    it "is the correct page" do
      expect(page).to have_css(".govuk-heading-xl", text: "Accessibility statement")
    end

    it "main is accessible" do
      expect(page).to be_accessible.within("#main-content")
    end
  end

  describe "CS Accelerator page" do
    let(:programme) { create(:cs_accelerator) }

    before do
      programme
      visit "/subject-knowledge"
    end

    it "is the correct page" do
      expect(page).to have_css(".text-certificate-hero__area--text", text: "Key stage 3 and GCSE Computer Science certificate")
    end

    it "main is accessible" do
      expect(page).to be_accessible.within("#main-content")
    end
  end

  context "Terms page" do
    before do
      visit terms_conditions_path
    end

    it "is the correct page" do
      expect(page).to have_content("National Centre for Computing Education Terms and Conditions")
    end

    it "main is accessible" do
      expect(page).to be_accessible.within("#main-content")
    end
  end

  context "404 page" do
    before do
      visit "/404"
    end

    it "is the correct page" do
      expect(page).to have_css(".govuk-heading-xl", text: "Page not found")
    end

    it "main is accessible" do
      expect(page).to be_accessible.within("#main-content")
    end
  end
end
