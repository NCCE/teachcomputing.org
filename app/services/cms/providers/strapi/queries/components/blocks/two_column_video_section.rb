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
                  rightColumnContent
                  #{ContentBlocks::EmbeddedVideo.embed(:video)}
                  #{SharedFields.color_theme(:bkColor)}
                  #{SharedFields.color_theme(:boxColor)}
                  #{Buttons::NcceButton.embed(:leftColumnButton)}
                  videoSide
                  #{EmbedBlocks::SectionTitle.embed(:gridRowTitle)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
