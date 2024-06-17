require "faker"
require "rails_helper"

RSpec.describe CareersVideoCardComponent, type: :component do
  let(:title) { Faker::Lorem.sentence }
  let(:name) { Faker::Name.name }
  let(:job_title) { Faker::Job.title }
  let(:description) { Faker::Lorem.sentence }

  before do
    render_inline(described_class.new(
      video_url: "https://www.youtube.com/watch?v=t0ojrm0fMoE&list=PLwcV67XMdDdJn_6BFs2h1yBeyZDArab7J&index=3",
      title:,
      name:,
      job_title:,
      description:
    ))
  end

  it "embeds a youtube video" do
    expect(page).to have_css("iframe")
  end

  it "has a title" do
    expect(page).to have_css("h2", text: title)
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
