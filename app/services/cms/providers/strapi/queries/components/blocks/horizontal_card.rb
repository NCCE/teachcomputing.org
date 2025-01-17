module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class HorizontalCard < BaseComponentQuery
              def self.fields
                super("ComponentBlocksHorizontalCard",
                  <<~GRAPHQL.freeze
                    hozcard_title: title
                    textContent
                    imageLink
                    externalTitle
                    spacing
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
