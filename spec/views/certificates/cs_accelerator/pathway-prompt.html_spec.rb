require "rails_helper"

RSpec.describe("certificates/cs_accelerator/_pathway-prompt", type: :view) do
  context "when user has no questionnaire_response" do

    before do
      render "certificates/cs_accelerator/pathway-prompt", user_programme_pathway: nil
    end

    it "renders correctly" do
      expect(rendered).to match("Not sure which courses are right for you?")
    end

    it "links to questionnaire" do
      expect(rendered).to have_link("Take our short questionnaire",
        href: diagnostic_cs_accelerator_certificate_path(:question_1))
    end
  end

  context "when user has pathway" do
    let(:programme) { create(:cs_accelerator) }
    let(:user) { create(:user) }
    let(:pathway) { create(:pathway, programme:)}
    let(:user_programme_enrolment) { create(:user_programme_enrolment, programme:, pathway:)}

    before do
      render "certificates/cs_accelerator/pathway-prompt", user_programme_pathway: pathway
    end

    it "should render the pathway title" do
      expect(rendered).to have_css("strong", text: pathway.title)
    end
  end
end
