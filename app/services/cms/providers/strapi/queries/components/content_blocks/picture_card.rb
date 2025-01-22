module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class PictureCard < BaseComponentQuery
              def self.name = "ComponentContentBlocksPictureCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{SharedFields.image_fields(:image)}
                  title
                  link
                  textContent
                  #{SharedFields.color_theme(:colorTheme)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
