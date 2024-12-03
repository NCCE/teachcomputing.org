module Cms
  module Providers
    module Strapi
      module Mocks
        class TestimonialRow < StrapiMock
          strapi_component "blocks.testimonial-row"

          attribute(:title) { Faker::Lorem.sentence }
          attribute(:backgroundColor) { nil }
          attribute(:testimonials) { Array.new(3) { Testimonial.generate_raw_data } }
        end
      end
    end
  end
end
