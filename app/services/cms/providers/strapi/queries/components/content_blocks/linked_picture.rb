module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class LinkedPicture < BaseComponentQuery
              def self.fields
                super("ComponentContentBlocksLinkedPicture",
                  <<~GRAPHQL.freeze
                    #{SharedFields.image_fields(:image)}
                    link
                  GRAPHQL
                )
              end
            end
          end
        end
      end
    end
  end
end
