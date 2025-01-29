module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class SplitHorizontalCard < BaseComponentQuery
              def self.name = "ComponentBlocksSplitHorizontalCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  shc__cardContent: cardContent
                  shc__asideContent: asideContent
                  asideTitle
                  #{SharedFields.image_fields(:asideIcon)}
                  sectionTitle
                  #{SharedFields.color_theme(:bkColor)}
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
