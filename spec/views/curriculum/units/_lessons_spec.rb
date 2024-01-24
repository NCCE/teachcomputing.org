require "rails_helper"

RSpec.describe("curriculum/units/_lessons", type: :view) do
  let(:unit_json) { File.new("spec/support/curriculum/views/unit.json").read }
  let(:key_stage_json) { File.new("spec/support/curriculum/views/key_stage.json").read }
  let(:user) { create(:user) }
  let(:unit) {
    JSON.parse(unit_json, object_class: OpenStruct).data.unit
  }
  let(:key_stage) {
    JSON.parse(key_stage_json, object_class: OpenStruct).data.key_stage
  }

  context "user not logged in" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
      render partial: "lessons", locals: {key_stage:, unit:, lessons: unit.lessons}
    end
    it "has a title" do
      expect(rendered).to have_css(".govuk-heading-m", text: "Lessons")
    end

    it "has list of lessons" do
      expect(rendered).to have_css(".govuk-list", count: 1)
    end

    it "has login button" do
      expect(rendered).to have_css(".govuk-button", text: "Log in to download")
    end
  end

  context "user logged in" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      render partial: "lessons", locals: {key_stage:, unit:, lessons: unit.lessons}
    end

    it "has download button" do
      expect(rendered).to have_css(".govuk-button", text: "Download all lesson files")
    end
  end
end
