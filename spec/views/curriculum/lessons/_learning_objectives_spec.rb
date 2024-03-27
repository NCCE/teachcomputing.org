require "rails_helper"

RSpec.describe("curriculum/lessons/_learning_objectives", type: :view) do
  context "when the key stage 1 or 2" do
    before do
      json =
        {
          objectives: [
            {
              description: "Some objective",
              success_criteria: [
                {description: "First criterion"},
                {description: "Second criterion"}
              ]
            },
            {
              description: "Bad objective that shouldn't be here"
            }
          ]
        }.to_json

      data = JSON.parse(json, object_class: OpenStruct)

      render partial: "curriculum/lessons/learning_objectives",
        locals: {
          key_stage_level: "1",
          objectives: data.objectives
        }
    end

    it "has a title" do
      expect(rendered).to have_text("Learning objectives")
    end

    it "displays the objective" do
      expect(rendered).to have_text("Some objective")
    end

    it "doesn't show the bad objective" do
      expect(rendered).not_to have_text("Bad objective")
    end

    it "lists all success criteria" do
      expect(rendered).to have_css(".govuk-list li", count: 2)
    end
  end

  context "when the key stage 3 or 4" do
    before do
      json =
        {
          objectives: [
            {
              description: "Some objective"
            },
            {
              description: "Another objective",
              success_criteria: [
                {description: "First criterion"},
                {description: "Second criterion"}
              ]
            }
          ]
        }.to_json
      data = JSON.parse(json, object_class: OpenStruct)

      render partial: "curriculum/lessons/learning_objectives",
        locals: {
          key_stage_level: "4",
          objectives: data.objectives
        }
    end

    it "shows all the objectives" do
      expect(rendered).to have_text("Some objective")
      expect(rendered).to have_text("Another objective")
    end

    it "doesn't list any success criteria" do
      expect(rendered).not_to have_text("criterion")
    end
  end
end
