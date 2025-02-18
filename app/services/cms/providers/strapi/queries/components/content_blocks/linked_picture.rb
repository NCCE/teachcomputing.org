module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class LinkedPicture < BaseComponentQuery
              def self.name = "ComponentContentBlocksLinkedPicture"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{SharedFields.image_fields(:image)}
                  link
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
