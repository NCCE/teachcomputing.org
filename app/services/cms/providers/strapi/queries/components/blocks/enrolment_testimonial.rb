module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class EnrolmentTestimonial < BaseComponentQuery
              def self.name = "ComponentBlocksEnrolmentTestimonial"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  #{ContentBlocks::Testimonial.embed(:testimonial)}
                  #{SharedFields.aside_sections(:enrolledAside)}
                  #{SharedFields.aside_sections(:enrolAside)}
                  #{SharedFields.color_theme(:bkColor)}
                  #{SharedFields.programme_slug}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
