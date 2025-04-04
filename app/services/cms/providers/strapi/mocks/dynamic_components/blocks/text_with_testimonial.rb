module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class TextWithTestimonial < StrapiMock
              strapi_component "blocks.text-with-testimonial"

              attribute(:textContent) { Text::RichBlocks.generate_data }
              attribute(:buttons) { [] }
              attribute(:testimonial) { ContentBlocks::Testimonial.generate_data }
              attribute(:testimonialSide) { "left" }
              attribute(:bkColor) { nil }
            end
          end
        end
      end
    end
  end
end
