module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class IconRow < BaseComponentQuery
              def self.name = "ComponentBlocksIconRow"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{SharedFields.icon_block("icons")}
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
