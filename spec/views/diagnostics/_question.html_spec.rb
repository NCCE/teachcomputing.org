require "rails_helper"

RSpec.describe("diagnostics/question", type: :view) do
  include DiagnosticHelper

  before do
    assign(:steps, %i[question_1 question_2])
  end

  context "when there is one question" do
    before do
      assign(:step, :question_1)
      render partial: "diagnostics/question",
        locals: {
          wizard_path: root_url,
          question: cs_accelerator_questions(:question_1)
        }
    end

    it "shows the expected question number" do
      expect(rendered).to have_css(".ncce-diagnostic__question-progress", text: "Question 1 of 2")
    end

    it "does not show the back link" do
      expect(rendered).not_to have_css(".govuk-back-link")
    end

    it "shows the question text" do
      expect(rendered).to have_css(".govuk-body-l")
    end

    it "shows the sub text" do
      expect(rendered).to have_css(".govuk-body")
    end

    it "shows the answers" do
      expect(rendered).to have_css(".govuk-radios__input", count: 4)
    end
  end

  context "when there is more than one question" do
    before do
      assign(:step, :question_2)
      render partial: "diagnostics/question",
        locals: {
          previous_wizard_path: root_url,
          wizard_path: root_url,
          question: cs_accelerator_questions(:question_2)
        }
    end

    it "shows the expected question number" do
      expect(rendered).to have_css(".ncce-diagnostic__question-progress", text: "Question 2 of 2")
    end

    it "shows the back link" do
      expect(rendered).to have_css(".govuk-back-link")
    end
  end
end
