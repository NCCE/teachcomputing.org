require "rails_helper"

RSpec.describe CourseOccurrencesComponent, type: :component do
  it "does not render if there are no occurrences" do
    course = instance_double(Achiever::Course::Template)
    allow(course).to receive(:occurrences).and_return([])
    render_inline(described_class.new(course: course))
    expect(page).not_to have_css(".course-occurrences-component")
  end
end
