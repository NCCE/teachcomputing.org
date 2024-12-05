# frozen_string_literal: true

class UserProgrammeCourseBookingsWithAsidesComponent < CmsWithAsidesComponent
  delegate :current_user, to: :helpers

  def initialize(programme:, aside_slug: nil)
    aside_sections = if aside_slug.nil?
      nil
    else
      [{slug: aside_slug}]
    end

    super(aside_sections:)
    @programme = programme
  end

  def before_render
    @current_user = current_user

    in_progress_achievements = current_user.achievements.in_state(:in_progress, :enrolled).with_courses.order("created_at DESC")
    complete_achievements = current_user.achievements.in_state(:complete).with_courses.order("created_at DESC")

    @courses =
      {
        in_progress: in_progress_achievements.belonging_to_programme(@programme),
        complete: complete_achievements.belonging_to_programme(@programme)
      }
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
