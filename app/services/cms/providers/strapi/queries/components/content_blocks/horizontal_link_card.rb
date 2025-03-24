module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class HorizontalLinkCard < BaseComponentQuery
              def self.name = "ComponentContentBlocksHorizontalLinkCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  linkUrl
                  cardContent
                  #{SharedFields.color_theme(:theme)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
