require "rails_helper"

RSpec.describe("courses/programme_courses", type: :view) do
  let!(:programme) { create(:primary_certificate) }
  let(:title) { "Teach primary computing certificate courses" }

  let(:courses) do
    build_list(
      :achiever_course_template,
      3,
      age_groups: ["157430010"],
      subjects: ["157430000"],
      occurrences: [build(:achiever_course_occurrence)]
    )
  end

  let(:filter_stub) { instance_double(Achiever::CourseFilter) }

  before do
    stub_template "courses/_courses-list" => ""
    stub_template "courses/_aside-filters" => ""
  end

  context "with a hub with no courses" do
    before do
      @programme = programme
      @certificate_filter = "primary-certificate"
      @filter_params = {}
      @course_filter = filter_stub
      @title = title
      render
    end

    it "has the clear filters link" do
      expect(rendered).to have_css(".govuk-heading-l", text: title)
    end
  end
end
