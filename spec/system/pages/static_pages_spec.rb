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

  describe "I Belong page", js: false do
    let(:user) { create(:user, email: "web@teachcomputing.org") }
    let(:programme) { create(:i_belong) }
    let(:enrolment) { create(:user_programme_enrolment, user:, programme:) }

    context "as a guest" do
      it "has guest content" do
        visit "/i-belong"
        expect(page).to have_css("h1", text: "I Belong: encouraging girls into computer science")
        expect(page).to have_css("li", text: "Enrol on the programme")
        expect(page).to have_link("Log in to enrol")
        expect(page).to have_link("Log in to request")
      end

      it "is accessible" do
        expect(page).to be_accessible.within("#main-content")
      end
    end

    context "when logged in" do
      before do
        programme
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      it "has logged in content" do
        visit "/i-belong"
        expect(page).to have_css("li", text: "Complete our ‘Encouraging Girls into GCSE Computer Science’ short course")
        expect(page).to have_css("li", text: "Participate in a range of recommended activity")
        expect(page).to have_link("Enrol on the programme")
        expect(page).to have_link("Enrol to request")
      end
    end

    context "when enrolled" do
      before do
        enrolment
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      it "has enrolled content" do
        visit "/i-belong"
        expect(page).to have_link("Visit dashboard")
        expect(page).to have_link("Request your posters")
        expect(page).to have_css("li", text: "Complete the I Belong short course for your key stage")
        expect(page).to have_css("li", text: "Participate in a range of recommended activity")
        expect(page).to have_css("li", text: "Claim your school certificate")
      end
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
