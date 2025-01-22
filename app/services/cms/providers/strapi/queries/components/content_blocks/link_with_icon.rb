module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class LinkWithIcon < BaseComponentQuery
              def self.name = "ComponentContentBlocksLinkWithIcon"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{SharedFields.image_fields(:icon)}
                  url
                  linkText
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
