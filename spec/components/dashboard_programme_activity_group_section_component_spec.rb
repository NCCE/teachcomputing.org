# frozen_string_literal: true

require "rails_helper"

RSpec.describe DashboardProgrammeActivityGroupSectionComponent, type: :component do
  context "with aside slug" do
    context "when cms returns aside" do
      before do
        stub_strapi_aside_section
        render_inline(described_class.new(
          title: "With Aside",
          completed: false,
          aside_slug: "testing-with-aside"
        )) { "Some content" }
      end

      it "should render title" do
        expect(page).to have_css(".govuk-heading-m", text: "With Aside")
      end

      it "should render content section" do
        expect(page).to have_css(".dashboard-programme-activity-group-section__content", text: "Some content")
      end

      it "should render two-thirds column" do
        expect(page).to have_css(".govuk-grid-column-two-thirds")
      end

      it "should render one-third column" do
        expect(page).to have_css(".govuk-grid-column-one-third")
      end

      it "should render an aside" do
        expect(page).to have_css(".aside-component")
      end
    end

    context "when cms fails to returns aside" do
      before do
        stub_strapi_aside_section_missing("testing-with-aside-missing")
        render_inline(described_class.new(
          title: "With Aside but missing",
          completed: false,
          aside_slug: "testing-with-aside-missing"
        )) { "Some content" }
      end

      it "should not render one-third column" do
        expect(page).not_to have_css(".govuk-grid-column-one-third")
      end

      it "should render an aside" do
        expect(page).not_to have_css(".aside-component")
      end
    end
  end

  context "without aside" do
    before do
      render_inline(described_class.new(
        title: "Without Aside",
        completed: false
      )) { "Some content" }
    end

    it "should render title" do
      expect(page).to have_css(".govuk-heading-m", text: "Without Aside")
    end

    it "should render content section" do
      expect(page).to have_css(".dashboard-programme-activity-group-section__content", text: "Some content")
    end

    it "should render two-thirds column" do
      expect(page).to have_css(".govuk-grid-column-two-thirds")
    end

    it "should not render one-third column" do
      expect(page).not_to have_css(".govuk-grid-column-one-third")
    end
  end

  context "when programme_activity_group has been completed" do
    before do
      render_inline(described_class.new(
        title: "Without Aside",
        completed: true
      )) { "Some content" }
    end

    it "should render complete flag" do
      expect(page).to have_css(".dashboard-programme-activity-group-section__completed-badge")
    end
  end

  context "when programme_activity_group has not been completed" do
    before do
      render_inline(described_class.new(
        title: "Without Aside",
        completed: false
      )) { "Some content" }
    end

    it "should not render complete flag" do
      expect(page).not_to have_css(".dashboard-programme-activity-group-section__completed-badge")
    end
  end

  context "without title" do
    before do
      render_inline(described_class.new(
        completed: false
      )) { "Some content" }
    end

    it "should not render complete flag" do
      expect(page).not_to have_css(".dashboard-programme-activity-group-section__title")
    end
  end
end
