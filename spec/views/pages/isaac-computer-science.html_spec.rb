require "rails_helper"

RSpec.describe("pages/isaac_computer_science", type: :view) do
  before do
    render
  end

  it "has a title" do
    expect(rendered).to have_css(".govuk-heading-l", text: "Isaac Computer Science")
  end

  it "has a intro section" do
    expect(rendered).to have_css(".govuk-body-l", text: "Discover the free online textbook for A level and GCSE computer science teachers and students.")
  end

  it "has a section about the transition to Ada Computer Science" do
    expect(rendered).to have_css(".light-grey-bg", text: "government-funded online student learning support will be provided through Ada Computer Science")
    expect(rendered).to have_link("this blog", href: "https://isaaccomputerscience.org/pages/2026_08_planned_transition")
  end

  it "shows 2 support cards" do
    expect(rendered).to have_css(".lp-support__card", count: 2)
  end

  it "has a Discover more button" do
    expect(rendered).to have_link("Discover Isaac Computer Science", href: "https://isaaccomputerscience.org/register")
  end

  it "has a create free account button" do
    expect(rendered).to have_link("Create your free account", href: "https://isaaccomputerscience.org/register")
  end
end
