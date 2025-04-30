module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class ProgrammePictureCardSection < BaseComponentQuery
              def self.name = "ComponentBlocksProgPictureCardSecs"

              def self.base_fields
                <<~GRAPHQL.freeze
                  ibc__sectionTitle: sectionTitle
                  introText
                  #{SharedFields.programme_slug("prog")}
                  #{ContentBlocks::ProgrammePictureCard.embed(:programmeCards)}
                  #{SharedFields.color_theme("bkColor")}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
