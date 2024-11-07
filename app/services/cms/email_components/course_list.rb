module Cms
  module EmailComponents
    class CourseList
      attr_accessor :section_title, :courses, :remove_on_match

      def initialize(section_title:, courses:, remove_on_match:)
        @section_title = section_title
        @courses = courses
        @remove_on_match = remove_on_match
      end

      def activity_list(email_template, user)
        latest_cpd = user.sorted_completed_cpd_achievements_by(programme: email_template.programme).last&.activity
        matched = false
        display_courses = @courses.select { !_1.substitute }.each_with_object([]) do |course, list|
          if course.activity == latest_cpd
            matched = true
          else
            list << course
          end
        end
        display_courses += @courses.select { _1.substitute } if matched
        display_courses
      end

      def render(email_template, user)
        CmsEmailCourseListComponent.new(course_list: activity_list(email_template, user), section_title:)
      end

      def render_text(email_template, user)
        CourseListText.new(activity_list(email_template, user), section_title:)
      end
    end

    class Course
      attr_accessor :activity_code, :display_name, :substitute, :activity

      def initialize(activity_code:, display_name:, substitute:)
        @activity_code = activity_code
        @display_name = display_name
        @substitute = substitute
        @activity = Activity.find_by(stem_activity_code: activity_code)
      end
    end

    class CourseListText
      include Rails.application.routes.url_helpers

      def initialize(course_list, section_title:)
        @course_list = course_list
        @section_title = section_title
      end

      def render_in(view_context)
        view_context.render inline: content
      end

      def content
        course_text = @course_list.map { display(_1) }.join("\n") + "\n"
        return "#{@section_title}\n\n#{course_text}" if @section_title

        course_text
      end

      def display(course)
        "#{course.display_name.presence || course.activity.title} (#{course_url(id: course.activity.stem_activity_code, name: course.activity.title.parameterize)})"
      end

      def format = :text
    end
  end
end
