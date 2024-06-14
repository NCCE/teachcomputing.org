require "faker"
require "rails_helper"

RSpec.describe CurriculumVideoComponent, type: :component do
  let(:name) { Faker::Name.name }
  let(:job_title) { Faker::Job.title }
  let(:description) { Faker::Lorem.sentence }

  context "with column layout" do
    before do
      render_inline(described_class.new(
        video_url: "https://www.youtube.com/watch?v=t0ojrm0fMoE&list=PLwcV67XMdDdJn_6BFs2h1yBeyZDArab7J&index=3",
        name:,
        job_title:,
        description:,
        layout: :col
      ))
    end

    it "has column class" do
      expect(page).to have_css(".video-component-col")
    end

    it "embeds a youtube video" do
      expect(page).to have_css("iframe")
    end

    it "has a name" do
      expect(page).to have_css(".govuk-body-s", text: name)
    end

    it "has a job title" do
      expect(page).to have_css(".govuk-body-s", text: job_title)
    end

    it "has a description" do
      expect(page).to have_css(".govuk-body-s", text: description)
    end
  end

  context "with row layout" do
    before do
      render_inline(described_class.new(
        video_url: "https://www.youtube.com/watch?v=t0ojrm0fMoE&list=PLwcV67XMdDdJn_6BFs2h1yBeyZDArab7J&index=3",
        name:,
        job_title:,
        description:,
        layout: :row
      ))
    end

    it "has row class" do
      expect(page).to have_css(".video-component-row")
    end

    it "embeds a youtube video" do
      expect(page).to have_css("iframe")
    end

    it "has a name" do
      expect(page).to have_css(".govuk-body-s", text: name)
    end

    it "has a job title" do
      expect(page).to have_css(".govuk-body-s", text: job_title)
    end

    it "has a description" do
      expect(page).to have_css(".govuk-body-s", text: description)
    end
  end

  context "with default layout" do
    before do
      render_inline(described_class.new(
        video_url: "https://www.youtube.com/watch?v=t0ojrm0fMoE&list=PLwcV67XMdDdJn_6BFs2h1yBeyZDArab7J&index=3",
        name:,
        job_title:,
        description:
      ))
    end

    it "applies default layout class" do
      expect(page).to have_css(".video-component-col")
    end
  end
end
