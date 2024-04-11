require "rails_helper"

RSpec.describe("curriculum/key_stages/index", type: :view) do
  let(:key_stages_json) { File.new("spec/support/curriculum/views/key_stages.json").read }
  let(:user) { create(:user) }
  let(:setup_view) do
    json = JSON.parse(key_stages_json, object_class: OpenStruct).data
    assign(:key_stages, json.key_stages)

    assign(:journey_progress_pdf, journey_progress_file(slug: "journey-progress-pdf", file_type: "pdf"))
    assign(:journey_progress_icon, journey_progress_file(slug: "journey-progress-icon", file_type: "icon"))
    assign(:primary_journey_progress_pdf, journey_progress_file(slug: "primary-journey-progress-pdf", file_type: "pdf"))
    assign(:secondary_journey_progress_pdf, journey_progress_file(slug: "secondary-journey-progress-pdf", file_type: "pdf"))
  end

  before do
    setup_view
    render
  end

  it "does not show the breadcrumb" do
    expect(rendered).not_to have_css(".curriculum__breadcrumb")
  end

  it "has a title" do
    expect(rendered).to have_text("Teach Computing Curriculum")
  end

  it "has a video in the hero" do
    expect(rendered).to have_css("iframe[src*='6VsXL8g4yNs']")
  end

  it "links to the journey poster" do
    expect(rendered).to have_link("viewing and progressing through our curriculum journey", href: "/curriculum/files/journey-progress-pdf")
    expect(rendered).to have_link("Primary", href: "/curriculum/files/primary-journey-progress-pdf")
    expect(rendered).to have_link("Secondary", href: "/curriculum/files/secondary-journey-progress-pdf")
  end

  it "has a section about what we do with bullet points" do
    expect(rendered).to have_text("Why use our Teach Computing Curriculum?")
    expect(rendered).to have_css(".govuk-list li", count: 5)
  end

  it "lists all the key stages" do
    expect(rendered).to have_css(".card--resource", text: "Key Stage 1")
    expect(rendered).to have_css(".card--resource", text: "Key Stage 2")
    expect(rendered).to have_css(".card--resource", text: "Key Stage 3")
    expect(rendered).to have_css(".card--resource", text: "Key Stage 4")
  end

  it "lists the expected counts" do
    # expect(rendered).to have_css('.card--resource__unit', text: 'Units: 42')
    expect(rendered).to have_css(".card--resource__lesson", text: "Lessons: 84")
  end

  it "links to the hubs page" do
    expect(rendered).to have_link("Contact your local hub", href: "/hubs")
  end

  it "links to the isaac page" do
    expect(rendered).to have_link(href: "/a-level-computer-science")
  end

  private

  def journey_progress_file(slug:, file_type:)
    extension = (file_type == "pdf") ? "pdf" : "png"

    OpenStruct.new({
      name: "Journey progress test file",
      file: "media/images/test/example.#{extension}",
      slug: slug
    })
  end
end
