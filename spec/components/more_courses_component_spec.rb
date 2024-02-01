require "rails_helper"

RSpec.describe MoreCoursesComponent, type: :component do
  let(:filter) { instance_double(Achiever::CourseFilter) }

  context "when searching within maximum radius" do
    it "shows message when there are more courses within max radius" do
      search_results = Achiever::LocationCourseSearchResult.new.tap do |sr|
        sr.radius_maxed = false
        sr.further_results_count = 23
        sr.max_radius = 88
        sr.courses_count = 9
      end
      allow(filter).to receive(:location_based_results).and_return(search_results)

      render_inline(described_class.new(course_filter: filter))
      expect(page).to have_text("There are 23 more face to face courses within 88 miles")
    end

    it "shows message when there is one more courses within max radius" do
      search_results = Achiever::LocationCourseSearchResult.new.tap do |sr|
        sr.radius_maxed = false
        sr.further_results_count = 1
        sr.max_radius = 88
        sr.courses_count = 9
      end
      allow(filter).to receive(:location_based_results).and_return(search_results)

      render_inline(described_class.new(course_filter: filter))
      expect(page).to have_text("There is 1 more face to face course within 88 miles")
    end
  end
end
