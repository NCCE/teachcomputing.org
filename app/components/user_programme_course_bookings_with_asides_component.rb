# frozen_string_literal: true

class UserProgrammeCourseBookingsWithAsidesComponent < CmsWithAsidesComponent
  def initialize(current_user:, courses:, programme:, aside_slug: nil)
    super(aside_sections: [{slug: aside_slug}])
    @current_user = current_user
    @courses = courses
    @programme = programme
  end

  def course_icon_class(activity)
    case activity.category.to_sym
    when :online
      "icon-online"
    else
      if activity.remote_delivered_cpd
        "icon-remote"
      else
        "icon-map-pin"
      end
    end
  end

  def course_duration(course)
    Achiever::Course::Template.maybe_find_by_activity_code(course.activity.stem_activity_code) if course.activity.stem_activity_code.present?
  end
end
