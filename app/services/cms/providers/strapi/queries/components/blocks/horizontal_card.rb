module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class HorizontalCard < BaseComponentQuery
              def self.name = "ComponentBlocksHorizontalCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  hozcard__title: title
                  hozcard__textContent: textContent
                  #{SharedFields.image_fields("image")}
                  imageLink
                  #{SharedFields.color_theme("colorTheme")}
                  #{SharedFields.icon_block("iconBlock")}
                  spacing
                  externalTitle
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
