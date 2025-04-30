module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class ProgrammeResourceCardSection < BaseComponentQuery
              def self.name = "ComponentBlocksProgResourceCardSecs"

              def self.base_fields
                <<~GRAPHQL.freeze
                  rcs__sectionTitle: sectionTitle
                  introText
                  #{SharedFields.programme_slug("prog")}
                  #{ContentBlocks::ProgrammeResourceCard.embed(:resourceCards)}
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
