module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class ButtonBlock < BaseComponentQuery
              def self.name = "ComponentBlocksButtonBlock"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{Buttons::NcceButton.embed(:buttons)}
                  #{SharedFields.color_theme(:bkColor)}
                  padding
                  alignment
                  fullWidth
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
