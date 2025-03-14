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
end
