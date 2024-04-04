require "rails_helper"

RSpec.describe("curriculum/key_stages/index", type: :view) do
  let(:key_stages_json) { File.new("spec/support/curriculum/views/key_stages.json").read }
  let(:user) { create(:user) }
  let(:setup_view) do
    json = JSON.parse(key_stages_json, object_class: OpenStruct).data
    assign(:key_stages, json.key_stages)
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
    expect(rendered).to have_link("viewing our curriculum journey poster", href: "https://static.teachcomputing.org/curriculum_journey.pdf")
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
end
