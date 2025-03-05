# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::EmailCourseListComponent, type: :component do
  let!(:activity) { create(:activity, stem_activity_code: "CP468") }
  let!(:activity2) { create(:activity, stem_activity_code: "CP123") }
  let(:course_list) {
    Cms::Mocks::EmailComponents::CourseList.as_model(
      courses: [
        Cms::Mocks::EmailComponents::Course.generate_data(activity_code: "CP468"),
        Cms::Mocks::EmailComponents::Course.generate_data(activity_code: "CP123")
      ]
    )
  }

  context "without section_title" do
    before do
      render_inline(described_class.new(courses: course_list.courses, section_title: nil))
    end

    it "should render as a table" do
      expect(page).to have_css("table")
    end

    it "should render two rows" do
      expect(page).to have_css("tr", count: 2)
    end
  end

  context "with section_title" do
    before do
      render_inline(described_class.new(courses: course_list.courses, section_title: "Pick a course"))
    end

    it "should render as a table" do
      expect(page).to have_css("table")
    end

    it "should render a header" do
      expect(page).to have_css("h2", text: "Pick a course")
    end

    it "should render two rows" do
      expect(page).to have_css("tr", count: 3)
    end
  end
end
