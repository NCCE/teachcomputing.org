module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class EnrolmentTestimonial < StrapiMock
              strapi_component "blocks.enrolment-testimonial"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:testimonial) { DynamicComponents::ContentBlocks::Testimonial.generate_raw_data }
              attribute(:enrolledAside) { Collections::AsideSection.generate_aside_list(aside_slugs: ["enrolled-aside"]) }
              attribute(:enrolAside) { Collections::AsideSection.generate_aside_list(aside_slugs: ["enrol-aside"]) }
              attribute(:programme) { {data: {attributes: {slug: "primary-certificate"}}} }
              attribute(:bkColor) { Meta::ColorScheme.generate_data(name: "light-grey") }
            end
          end
        end
      end
    end
  end
end
