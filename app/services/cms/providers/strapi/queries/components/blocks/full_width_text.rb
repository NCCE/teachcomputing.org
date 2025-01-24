module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class FullWidthText < BaseComponentQuery
              def self.name = "ComponentBlocksFullWidthText"

              def self.base_fields
                <<~GRAPHQL.freeze
                  fwt__textContent: textContent
                  showBottomBorder
                  #{SharedFields.color_theme(:backgroundColor)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
