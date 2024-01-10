require "rails_helper"

RSpec.describe LocationSearchResultsComponent, type: :component do
  let(:filter_double) { instance_double(Achiever::CourseFilter) }

  it "does not render if not location search" do
    allow(filter_double).to receive(:location_search?).and_return(false)
    render_inline(described_class.new(course_filter: filter_double))
    expect(page).not_to have_css(".location-search-results-component")
  end

  it "shows error message if no results at all" do
    allow(filter_double).to receive(:location_search?).and_return(true)
    allow(filter_double).to receive(:current_hub).and_return(nil)
    search_results = Achiever::LocationCourseSearchResult.new.tap do |sr|
      sr.courses_count = 0
      sr.further_results_count = 0
      sr.outside_max_radius_results_count = 0
      sr.non_location_based_results_count = 0
    end
    allow(filter_double).to receive(:location_based_results).and_return(search_results)
    render_inline(described_class.new(course_filter: filter_double))
    expect(page).to have_text("Sorry, we couldn't find any courses")
  end
end
