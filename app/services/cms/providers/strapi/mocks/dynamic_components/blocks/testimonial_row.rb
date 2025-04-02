module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class TestimonialRow < StrapiMock
              strapi_component "blocks.testimonial-row"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:backgroundColor) { nil }
              attribute(:testimonials) { Array.new(3) { DynamicComponents::ContentBlocks::Testimonial.generate_raw_data } }
            end
          end
        end
      end
    end
  end
end
