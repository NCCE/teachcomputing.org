# frozen_string_literal: true

require "rails_helper"

RSpec.describe CpdCourseListComponent, type: :component do
  let(:current_user) { create(:user) }
  let(:courses) { create_list(:programme_activity, 3) }

  before do
    stub_course_templates
  end

  context "without seperator" do
    before do
      render_inline(described_class.new(current_user:, courses:))
    end

    it "should render correct number of courses" do
      expect(page).to have_css(".cpd-course-list__course", count: 3)
    end
  end

  context "with seperator" do
    before do
      render_inline(described_class.new(current_user:, courses:, show_seperator: true))
    end

    it "should render correct number of seperator" do
      expect(page).to have_css(".cpd-course-list__seperator", count: 2)
    end
  end
end
