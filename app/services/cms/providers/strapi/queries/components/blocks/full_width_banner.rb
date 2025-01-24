module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class FullWidthBanner < BaseComponentQuery
              def self.name = "ComponentBlocksFullWidthBanner"

              def self.base_fields
                <<~GRAPHQL.freeze
                  fwb__textContent: textContent
                  #{SharedFields.image_fields(:image)}
                  imageSide
                  buttons {
                    #{Buttons::NcceButton.base_fields}
                  }
                  imageLink
                  #{SharedFields.color_theme(:backgroundColor)}
                  sectionTitle
                  showBottomBorder
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
