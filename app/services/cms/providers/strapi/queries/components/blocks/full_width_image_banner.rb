module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class FullWidthImageBanner < BaseComponentQuery
              def self.name = "ComponentBlocksFullWidthImageBanner"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{SharedFields.image_fields(:backgroundImage)}
                  overlayTitle
                  overlayText
                  #{SharedFields.image_fields(:overlayIcon)}
                  overlaySide
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
