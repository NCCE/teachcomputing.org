module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class HorizontalCardWithAsides < BaseComponentQuery
              def self.name = "ComponentBlocksHorizontalCardWithAsides"

              def self.base_fields
                <<~GRAPHQL.freeze
                  textContent
                  #{SharedFields.aside_sections(:asides)}
                  #{Buttons::NcceButton.embed(:button)}
                  #{SharedFields.color_theme("theme")}
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
