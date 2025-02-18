module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class Testimonial < BaseComponentQuery
              def self.name = "ComponentContentBlocksTestimonial"

              def self.base_fields
                <<~GRAPHQL.freeze
                  quote
                  #{SharedFields.image_fields(:avatar)}
                  name
                  jobTitle
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
