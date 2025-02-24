module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class EmbeddedVideo < BaseComponentQuery
              def self.name = "ComponentContentBlocksEmbeddedVideo"

              def self.base_fields
                <<~GRAPHQL.freeze
                  url
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
