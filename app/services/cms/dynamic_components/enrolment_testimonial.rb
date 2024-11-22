module Cms
  module DynamicComponents
    class EnrolmentTestimonial
      attr_accessor :title, :testimonial, :enrolled_aside, :programme_slug, :background_color

      def initialize(title:, testimonial:, enrolled_aside:, programme_slug:, background_color:)
        @title = title
        @testimonial = testimonial
        @enrolled_aside = enrolled_aside
        @programme_slug = programme_slug
        @background_color = background_color
      end

      def render
        EnrolmentTestimonialComponent.new(title:, testimonial:, enrolled_aside:, programme_slug:, background_color:)
      end
    end
  end
end
