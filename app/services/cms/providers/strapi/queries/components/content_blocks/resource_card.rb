module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class ResourceCard < BaseComponentQuery
              def self.name = "ComponentContentBlocksResourceCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  #{SharedFields.image_fields(:icon)}
                  #{SharedFields.color_theme(:colorTheme)}
                  textContent
                  buttonText
                  buttonLink
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
