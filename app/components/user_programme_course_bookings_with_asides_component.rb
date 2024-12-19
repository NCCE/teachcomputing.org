# frozen_string_literal: true

class UserProgrammeCourseBookingsWithAsidesComponent < CmsWithAsidesComponent
  delegate :current_user, :activity_icon_class, to: :helpers

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
  end

  private

  def course_sections
    [{title: "Booked courses", courses: in_progress_courses},
      {title: "Completed courses", courses: completed_courses}]
  end

  def in_progress_courses
    @current_user.achievements
      .in_state(:in_progress, :enrolled)
      .with_courses.order("achievements.created_at DESC")
      .belonging_to_programme(@programme)
      .includes([:activity])
  end

  def completed_courses
    @current_user.achievements
      .in_state(:complete)
      .with_courses.order("achievements.created_at DESC")
      .belonging_to_programme(@programme)
      .includes([:activity])
  end

  def course_grouping
    @programme.programme_activity_groupings.not_community.first
  end

  def course_instance(course)
    Achiever::Course::Template.maybe_find_by_activity_code(course.activity.stem_activity_code) if course.activity.stem_activity_code.present?
  end
end
