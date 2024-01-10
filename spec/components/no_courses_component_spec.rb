require "rails_helper"

RSpec.describe NoCoursesComponent, type: :component do
  it "shows link to all courses" do
    render_inline(described_class.new(hub: nil))
    expect(page).to have_link("Show all courses", href: "/courses#results-top")
  end

  it "shows correct text" do
    render_inline(described_class.new(hub: nil))
    expect(page).to have_text("Sorry, we couldn't find any courses")
  end

  context "when hub is present" do
    it "has a title" do
      render_inline(described_class.new(hub: "asdf"))
      expect(page).to have_text("Sorry, this Computing Hub is currently not running any courses.")
    end
  end
end
