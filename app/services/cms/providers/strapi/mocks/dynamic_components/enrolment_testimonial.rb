module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          class EnrolmentTestimonial < StrapiMock
            strapi_component "blocks.enrolment-testimonial"

            attribute(:title) { Faker::Lorem.sentence }
            attribute(:testimonial) { Cms::Mocks::Testimonial.generate_raw_data }
            attribute(:enrolledAside) { Cms::Mocks::AsideSection.generate_aside_list(aside_slugs: ["enrolled-aside"]) }
            attribute(:enrolAside) { Cms::Mocks::AsideSection.generate_aside_list(aside_slugs: ["enrol-aside"]) }
            attribute(:programme) { {data: {attributes: {slug: "primary-certificate"}}} }
            attribute(:bkColor) { ColorScheme.generate_data(name: "light-grey") }
          end
        end
      end
    end
  end
end
