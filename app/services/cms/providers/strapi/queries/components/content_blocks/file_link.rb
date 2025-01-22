module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class FileLink < BaseComponentQuery
              def self.name = "ComponentContentBlocksFileLink"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{SharedFields.image_fields(:file)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
