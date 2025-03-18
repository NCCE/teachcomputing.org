module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class TwoColumnPictureSection < BaseComponentQuery
              def self.name = "ComponentBlocksTwoColumnPictureSection"

              def self.base_fields
                <<~GRAPHQL.freeze
                  textContent
                  tcp__imageSide: imageSide
                  tcp__image: #{SharedFields.image_fields(:image)}
                  #{SharedFields.color_theme(:bkColor)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
