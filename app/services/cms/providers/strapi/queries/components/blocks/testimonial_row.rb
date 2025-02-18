module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class TestimonialRow < BaseComponentQuery
              def self.name = "ComponentBlocksTestimonialRow"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  #{ContentBlocks::Testimonial.embed(:testimonials)}
                  #{SharedFields.color_theme(:backgroundColor)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
