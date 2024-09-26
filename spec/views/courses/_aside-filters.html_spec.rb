require "rails_helper"

RSpec.describe("courses/_aside-filters", type: :view) do
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
  let(:subjects) { {"Algorithmic thinking": 100_000_011, Biology: 157_430_000, Careers: 157_430_001} }
  let(:age_groups) { {"Key stage 1": 157_430_008, "Key stage 2": 157_430_009} }
  let(:certificates) { {"CS Accelerator": "subject-knowledge"} }

  describe "courses" do
    context "with no filters applied" do
      before do
        allow(filter_stub).to receive_messages(
          course_tags: {Algorithms: "101"},
          age_groups: age_groups,
          subjects: subjects,
          certificates: certificates,
          courses: courses,
          course_formats: [{label: "Face to face", value: "face_to_face"},
            {label: "Online", value: "online"},
            {label: "Live Remote", value: "remote"}],
          current_hub: "bla",
          current_hub_id: nil,
          current_level: nil,
          current_location: nil,
          current_topic: nil,
          current_format: [],
          current_certificate: nil,
          applied_filters: %w[bla],
          search_radii: [20, 30, 40, 50, 60],
          current_radius: 40,
          total_results_count: 3
        )

        @filter_params = {hub_id: "bla"}
        @course_filter = filter_stub
        render
      end

      it "renders a title" do
        expect(rendered).to have_text("Filter courses")
      end

      it "does not render the filters applied count" do
        expect(rendered).to have_css(".ncce-courses__filter-form-toggle-applied.hidden")
      end

      it "renders the filter aside closed by default" do
        expect(rendered).to have_css(".ncce-courses__filter-form-toggle")
      end

      it "renders level select" do
        expect(rendered).to have_select(:level, with_options: ["Any level", "Key stage 1", "Key stage 2"])
      end

      it "renders topic select" do
        expect(rendered).to have_select(:topic, with_options: ["Any topic", "Algorithms"])
      end

      it "renders certificate select" do
        expect(rendered).to have_select(:certificate, options: ["Any certificate", "CS Accelerator"])
      end

      it "renders the checkboxes" do
        expect(rendered).to have_css(".ncce-checkboxes__input", count: 3)

        expect(rendered).to have_css(".ncce-checkboxes__label", text: "Face to face")
        expect(rendered).to have_css(".ncce-checkboxes__label", text: "Online")
        expect(rendered).to have_css(".ncce-checkboxes__label", text: "Remote")
      end

      it "has a view results button" do
        expect(rendered).to have_css(".ncce-courses__view-results", text: "View 3 results")
      end

      it "has a submit button when js is disabled" do
        expect(rendered).to have_button("Apply filters")
      end
    end

    context "with filters applied" do
      before do
        allow(filter_stub).to receive_messages(
          course_tags: {Algorithms: "101"},
          age_groups: age_groups,
          subjects: subjects,
          certificates: certificates,
          courses: courses,
          course_formats: [{label: "Face to face", value: "face_to_face"},
            {label: "Online", value: "online"},
            {label: "Live Remote", value: "remote"}],
          current_hub: "bla",
          current_hub_id: nil,
          current_level: nil,
          current_location: nil,
          current_topic: nil,
          current_format: [],
          current_certificate: "subject-knowledge",
          applied_filters: %w[bla subject-knowledge],
          search_radii: [20, 30, 40, 50, 60],
          current_radius: 40,
          total_results_count: 3
        )

        @filter_params = {hub_id: "bla", certificate: "subject-knowledge"}
        @course_filter = filter_stub
        render
      end

      it "renders the filters applied count" do
        expect(rendered).not_to have_css(".ncce-courses__filter-form-toggle-applied.hidden")
        expect(rendered).to have_css(".ncce-courses__filter-form-toggle-applied", text: "1 filter applied")
      end

      it "selects the filter" do
        expect(rendered).to have_select(
          :certificate, selected: ["CS Accelerator"], options: ["Any certificate", "CS Accelerator"]
        )
      end
    end

    describe "with programme preselected" do
      before do
        allow(filter_stub).to receive_messages(
          course_tags: {Algorithms: "101"},
          age_groups: age_groups,
          subjects: subjects,
          certificates: "primary-certificate",
          courses: courses,
          course_formats: [{label: "Face to face", value: "face_to_face"},
            {label: "Online", value: "online"},
            {label: "Live Remote", value: "remote"}],
          current_hub: "bla",
          current_hub_id: nil,
          current_level: nil,
          current_location: nil,
          current_topic: nil,
          current_format: [],
          current_certificate: "subject-knowledge",
          applied_filters: %w[bla subject-knowledge],
          search_radii: [20, 30, 40, 50, 60],
          current_radius: 40,
          total_results_count: 3
        )
        @certificate_filter = "primary-certificate"
        @filter_params = {}
        @course_filter = filter_stub
        render
      end

      it "should not show the certificate_select" do
        expect(rendered).not_to have_css("select[name='certificate']")
      end

      it "should set certificate in a hidden attribute" do
        expect(rendered).to have_css("input[name='certificate'][value='primary-certificate']", visible: false)
      end
    end
  end
end
