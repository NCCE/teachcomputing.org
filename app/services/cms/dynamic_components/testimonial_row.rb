module Cms
  module DynamicComponents
    class TestimonialRow
      attr_accessor :title, :testimonials, :background_color

      def initialize(title:, testimonials:, background_color:)
        @title = title
        @testimonials = testimonials
        @background_color = background_color
      end

      def render
        CmsTestimonialRowComponent.new(title:, testimonials:, background_color:)
      end
    end
  end
end
