module Cms
  module DynamicComponents
    module Blocks
      class TextWithTestimonial
        attr_accessor :text_content, :buttons, :testimonial_side, :testimonial, :background_color

        def initialize(text_content:, buttons:, testimonial_side:, testimonial:, background_color:)
          @text_content = text_content
          @buttons = buttons
          @testimonial_side = testimonial_side
          @testimonial = testimonial
          @background_color = background_color
        end

        def render
          Cms::TextWithTestimonialComponent.new(text_content:, buttons:, testimonial_side:, testimonial:, background_color:)
        end
      end
    end
  end
end
