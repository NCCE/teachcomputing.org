# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::CourseCardComponent, type: :component do
  let(:course) {Achiever::Course::Template.all.first}
  before do
    stub_course_templates
    stub_duration_units
  end

  context "given title" do
    before do
      render_inline(described_class.new(
        title: "Learn how to teach computing",
        banner_text: "Banner text",
        course: course,
        description: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model
      ))
    end

    it "renders the banner text and makes it uppercase" do
      expect(page).to have_css(".courses-cms-card__banner", text: "BANNER TEXT")
    end

    it "renders title as link" do
      expect(page).to have_link("Learn how to teach computing", href: "/courses/#{course.activity_code}/#{course.title.parameterize}")
    end

    it "renders description" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "renders image" do
      expect(page).to have_css(".cms-image")
    end
  end

  context "without title" do
    before do
      render_inline(described_class.new(
        title: nil,
        banner_text: "Banner text",
        course:,
        description: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model
      ))
    end

    it "renders title as link" do
      expect(page).to have_link(course.title, href: "/courses/#{course.activity_code}/#{course.title.parameterize}")
    end

  end

  context "when course is nil" do
    before do
      render_inline(described_class.new(
        title: nil,
        banner_text: "Banner text",
        course: nil,
        description: Cms::Mocks::RichBlocks.as_model,
        image: Cms::Mocks::Image.as_model
      ))
    end

    it "doesnt render" do
      expect(page).not_to have_css(".courses-cms-card")
    end
  end


  context "when description is nil" do
    before do
      render_inline(described_class.new(
        title: nil,
        banner_text: "Banner text",
        course:,
        description: nil,
        image: Cms::Mocks::Image.as_model
      ))
    end

    it "does render" do
      expect(page).to have_css(".courses-cms-card")
    end
  end
end
