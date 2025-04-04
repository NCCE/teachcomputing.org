module Cms
  module Models
    module DynamicComponents
      module Blocks
        class EnrolmentTestimonial
          attr_accessor :title, :testimonial, :enrolled_aside, :enrol_aside, :programme_slug, :background_color

          def initialize(title:, testimonial:, enrolled_aside:, enrol_aside:, programme_slug:, background_color:)
            @title = title
            @testimonial = testimonial
            @enrolled_aside = enrolled_aside
            @programme_slug = programme_slug
            @background_color = background_color
            @enrol_aside = enrol_aside
          end

          def render
            EnrolmentTestimonialComponent.new(title:, testimonial:, enrolled_aside:, enrol_aside:, programme_slug:, background_color:)
          end
        end
      end
    end
  end
end
