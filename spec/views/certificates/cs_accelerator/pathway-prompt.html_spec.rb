require "rails_helper"

RSpec.describe("certificates/cs_accelerator/_pathway-prompt", type: :view) do
  context "when user has no questionnaire_response" do
    it "renders correctly" do
      render "certificates/cs_accelerator/pathway-prompt", user_programme_pathway: nil
      expect(rendered).to match("Not sure which courses are right for you?")
    end

    it "links to questionnaire" do
      render "certificates/cs_accelerator/pathway-prompt", user_programme_pathway: nil
      expect(rendered).to have_link("Take our short questionnaire",
        href: diagnostic_cs_accelerator_certificate_path(:question_1))
    end
  end
end
