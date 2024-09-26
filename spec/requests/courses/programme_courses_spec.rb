require "rails_helper"

RSpec.describe CoursesController do
  let(:programme) { create(:primary_certificate) }

  describe "GET #programme_courses" do
    before do
      stub_age_groups
      stub_course_templates
      stub_face_to_face_occurrences
      stub_online_occurrences
      stub_subjects
    end

    context "when there is no filtering" do
      before do
        get primary_courses_path
      end

      it "assigns @certificate_filter" do
        expect(assigns(:certificate_filter)).to eq("primary-certificate")
      end

      it "assigns @course_filter" do
        expect(assigns(:course_filter)).to be_a(Achiever::CourseFilter)
      end

      it "renders the correct template" do
        expect(response).to render_template("programme_courses")
      end

      it "doesn't show a flash notice" do
        expect(flash[:notice]).not_to be_present
      end
    end

    context "when using filtering" do
      before do
        programme
        get primary_courses_path, params: {
          level: "Key stage 1",
          topic: "Computing"
        }
      end

      it "assigns @certificate_filter" do
        expect(assigns(:certificate_filter)).to eq("primary-certificate")
      end

      it "passes params through to course filter as expected" do
        filters = assigns(:course_filter).applied_filters
        expect(filters)
          .to match_array(
            ["Key stage 1", "Computing"]
          )
      end
    end
  end
end
