# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::CourseCardComponent, type: :component do
  before do
    stub_course_templates
    stub_duration_units
    @course = Achiever::Course::Template.all.first
    render_inline(described_class.new(
      title: "Learn how to teach computing",
      banner_text: "Banner text",
      course: @course,
      description: Cms::Mocks::RichBlocks.as_model,
      image: Cms::Mocks::Image.as_model
    ))
  end

  it "renders the banner text and makes it uppercase" do
    expect(page).to have_css(".courses-cms-card__banner", text: "BANNER TEXT")
  end

  it "renders title as link" do
    expect(page).to have_link("Learn how to teach computing", href: "/courses/#{@course.activity_code}/#{@course.title.parameterize}")
  end

  it "renders description" do
    expect(page).to have_css(".cms-rich-text-block-component")
  end

  it "renders image" do
    expect(page).to have_css(".cms-image")
  end
end
