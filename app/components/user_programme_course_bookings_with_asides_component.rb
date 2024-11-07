# frozen_string_literal: true

class UserProgrammeCourseBookingsWithAsidesComponent < CmsWithAsidesComponent
  def initialize(courses:, programme:, aside_slug: nil)
    super(aside_sections: [{slug: aside_slug}])
    @courses = courses
    @programme = programme
  end
end
