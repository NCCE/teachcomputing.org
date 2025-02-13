module Cms
  module DynamicComponents
    class CourseCard
      attr_accessor :title, :banner_text, :course, :description, :image

      def initialize(title:, banner_text:, course_code:, description:, image:)
        @title = title
        @banner_text = banner_text
        @description = description
        @image = image
        @course = begin
          Achiever::Course::Template.find_by_activity_code(course_code)
        rescue ActiveRecord::RecordNotFound
          nil
        end
      end

      def render
        Cms::CourseCardComponent.new(title:, banner_text:, course:, description:, image:)
      end
    end
  end
end
