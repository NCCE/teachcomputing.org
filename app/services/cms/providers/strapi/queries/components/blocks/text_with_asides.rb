module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class TextWithAsides < BaseComponentQuery
              def self.fields
                super("ComponentBlocksTextWithAsides",
                  <<~GRAPHQL.freeze
                    textContent
                    #{SharedFields.aside_sections}
                    #{SharedFields.color_theme(:bkColor)}
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
