module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class FullWidthText < BaseComponentQuery
              def self.fields
                super("ComponentBlocksFullWidthText",
                  <<~GRAPHQL.freeze
                    textContent
                    showBottomBorder
                    #{SharedFields.color_theme(:backgroundColor)}
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
