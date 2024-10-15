# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsTestimonialComponent, type: :component do
  let(:name) { Faker::Name.name }
  let(:job_title) { Faker::Job.title }

  before do
    render_inline(described_class.new(
      name:,
      job_title:,
      avatar: Cms::Mocks::Image.as_model,
      quote: Cms::Mocks::RichBlocks.as_model
    ))
  end

  it "should render the name" do
    expect(page).to have_css(".name", text: name)
  end

  it "should render job title" do
    expect(page).to have_css(".job-title", text: job_title)
  end
end
