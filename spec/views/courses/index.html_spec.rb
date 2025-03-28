require "rails_helper"

RSpec.describe("courses/index", type: :view) do
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

  before do
    @filter_params = {}
    @course_filter = filter_stub
    render
  end

  it "has a title" do
    expect(rendered).to have_css(
      ".govuk-heading-xl",
      text: "Computing courses for teachers"
    )
  end

  it "renders the courses_list partial" do
    expect(rendered).to render_template(partial: "courses/_courses-list")
  end

  it "renders the filters partial" do
    expect(rendered).to render_template(partial: "courses/_aside-filters")
  end
end
