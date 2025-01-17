module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class TextBlock < BaseComponentQuery
              def self.fields
                super("ComponentContentBlocksTextBlock",
                  <<~GRAPHQL.freeze
                    textContent
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
