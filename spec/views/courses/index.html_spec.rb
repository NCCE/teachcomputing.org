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

  context "with no hub" do
    before do
      allow(filter_stub).to receive_messages(
        current_hub: nil
      )
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

    it "does not render the hub details" do
      expect(rendered).not_to have_css("ncce-courses__hub-container")
    end
  end

  context "with a hub" do
    before do
      allow(filter_stub).to receive_messages(
        current_hub: "bla"
      )
      @filter_params = {hub_id: "bla"}
      @course_filter = filter_stub
      render
    end

    it "has the expected title" do
      expect(rendered).to have_text("Showing courses run by bla")
    end

    it "has the clear filters link" do
      expect(rendered).to have_link("show all results", href: courses_path(anchor: "results-top"))
    end
  end

  context "with a hub with no courses" do
    before do
      allow(filter_stub).to receive_messages(
        current_hub: :no_courses
      )
      @filter_params = {hub_id: "bla"}
      @course_filter = filter_stub
      render
    end

    it "has the expected title" do
      expect(rendered).to have_text("There are no courses to show from this Computing Hub")
    end

    it "has the clear filters link" do
      expect(rendered).to have_link("show all results", href: courses_path(anchor: "results-top"))
    end
  end
end
