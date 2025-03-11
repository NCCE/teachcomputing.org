module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class TextWithAsides < BaseComponentQuery
              def self.name = "ComponentBlocksTextWithAsides"

              def self.base_fields
                <<~GRAPHQL.freeze
                  textContent
                  #{SharedFields.aside_sections}
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
