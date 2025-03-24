module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class BannerWithCards < BaseComponentQuery
              def self.name = "ComponentBlocksBannerWithCards"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  textContent
                  #{SharedFields.color_theme(:bkColor)}
                  #{ContentBlocks::HorizontalLinkCard.embed(:cards)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
