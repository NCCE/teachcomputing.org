module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class NumberedIconList < BaseComponentQuery
              def self.name = "ComponentBlocksNumberedIconList"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{SharedFields.image_fields(:titleIcon)}
                  title
                  points {
                    textContent
                  }
                  #{SharedFields.aside_sections(:asideSections)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
