module Cms
  module DynamicComponents
    module Blocks
      class TestimonialRow
        attr_accessor :title, :testimonials, :background_color

        def initialize(title:, testimonials:, background_color:)
          @title = title
          @testimonials = testimonials
          @background_color = background_color
        end

        def render
          Cms::TestimonialRowComponent.new(title:, testimonials:, background_color:)
        end
      end
    end
  end
end
