# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::TestimonialComponent, type: :component do
  let(:name) { Faker::Name.name }
  let(:job_title) { Faker::Job.title }
  let(:avatar) { Cms::Mocks::Image.as_model }
  let(:quote) { Cms::Mocks::RichBlocks.as_model }

  before do
    render_inline(described_class.new(
      name:,
      job_title:,
      avatar:,
      quote:
    ))
  end

  it "should render the name" do
    expect(page).to have_css(".name", text: name)
  end

  it "should render job title" do
    expect(page).to have_css(".job-title", text: job_title)
  end

  it "should render the image" do
    expect(page).to have_css("img[src='#{avatar.formats[:medium][:url]}']")
  end

  it "should render the quote text" do
    expect(page).to have_css(".cms-rich-text-block-component")
  end

  context "with dark background color" do
    before do
      render_inline(described_class.new(
        name:,
        job_title:,
        avatar:,
        quote:,
        background_color: "purple"
      ))
    end

    it "should have the light job title class" do
      expect(page).to have_css(".job-title--light")
    end
  end
end
