module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class TwoColumnVideoSection < BaseComponentQuery
              def self.name = "ComponentBlocksTwoColumnVideoSection"

              def self.base_fields
                <<~GRAPHQL.freeze
                  leftColumnContent
                  #{ContentBlocks::EmbeddedVideo.embed(:video)}
                  rightColumnContent
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
