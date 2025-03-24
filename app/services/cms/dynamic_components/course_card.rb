module Cms
  module DynamicComponents
    class CourseCard
      attr_accessor :title, :banner_text, :course, :description, :image

      def initialize(title:, banner_text:, course_code:, description:, image:)
        @title = title
        @banner_text = banner_text
        @description = description
        @image = image

        activity = Activity.find_by(stem_activity_code: course_code)
        @course = if activity
          if activity.replaced_by
            get_achiever_course(activity.replaced_by)
          elsif activity
            get_achiever_course(activity)
          end
        end
      end

      def get_achiever_course(activity)
        Achiever::Course::Template.find_by_activity_code(activity.stem_activity_code)
      rescue ActiveRecord::RecordNotFound
        nil
      end

      def render
        Cms::CourseCardComponent.new(title:, banner_text:, course:, description:, image:)
      end
    end
  end
end
