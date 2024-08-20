# frozen_string_literal: true

require "rails_helper"

RSpec.describe CpdCourseItemComponent, type: :component do
  let(:current_user) { create(:user) }
  let(:activity) { create(:activity, public_copy_additional_icons: ["Primary"]) }

  before do
    stub_course_templates
  end

  context "without achievement" do
    before do
      render_inline(described_class.new(activity:, current_user:))
    end

    it "should render the element" do
      expect(page).to have_css(".cpd-course-item")
    end

    it "should render title" do
      expect(page).to have_css(".govuk-body", text: activity.title)
    end

    it "should render the book now button" do
      expect(page).to have_link("Book now", href: "/courses/#{activity.stem_activity_code}/#{activity.slug}")
    end

    it "should show activity_type icon" do
      expect(page).to have_css("p.icon-map-pin")
    end

    it "should show addtional icon" do
      expect(page).to have_css("p.icon-person", text: "Primary")
    end
  end

  context "when complete" do
    let!(:achievement) { create(:completed_achievement, user: current_user, activity:) }

    before do
      render_inline(described_class.new(activity:, current_user:))
    end

    it "should show completed flag" do
      expect(page).to have_css(".status-tag", text: "Completed")
    end

    it "should not show book button" do
      expect(page).not_to have_link("Book now", href: "/courses/#{activity.stem_activity_code}/#{activity.slug}")
    end
  end

  context "when in progress" do
    let!(:achievement) { create(:achievement, user: current_user, activity:) }

    before do
      render_inline(described_class.new(activity:, current_user:))
    end

    it "should show completed flag" do
      expect(page).to have_css(".status-tag", text: "In progress")
    end

    it "should not show book button" do
      expect(page).not_to have_link("Book now", href: "/courses/#{activity.stem_activity_code}/#{activity.slug}")
    end
  end
end
