module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module EmbedBlocks
            class SideBanner < BaseComponentQuery
              def self.name = "ComponentContentBlocksSideBanner"

              def self.base_fields
                <<~GRAPHQL.freeze
                  textContent
                  #{SharedFields.image_fields(:icon)}
                  #{SharedFields.color_theme(:bannerColor)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
