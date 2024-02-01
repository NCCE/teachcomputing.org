require "rails_helper"

RSpec.describe("curriculum/units/_lessons", type: :view) do
  let(:unit_json) { File.new("spec/support/curriculum/views/unit.json").read }

  let(:key_stage_json) { File.new("spec/support/curriculum/views/key_stage.json").read }

  before do
    unit = JSON.parse(unit_json, object_class: OpenStruct).data.unit
    key_stage = JSON.parse(key_stage_json, object_class: OpenStruct).data.key_stage
    render partial: "lessons", locals: {key_stage: key_stage, unit: unit, lessons: unit.lessons}
  end

  it "has a title" do
    expect(rendered).to have_css(".govuk-heading-m", text: "Lessons")
  end

  it "has list of lessons" do
    expect(rendered).to have_css(".govuk-list", count: 1)
  end
end
