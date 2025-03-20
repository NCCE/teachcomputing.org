module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class Link < BaseComponentQuery
              def self.name = "ComponentContentBlocksLink"

              def self.base_fields
                <<~GRAPHQL.freeze
                  linkText
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
