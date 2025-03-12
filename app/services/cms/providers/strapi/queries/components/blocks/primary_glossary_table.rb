module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class PrimaryGlossaryTable < BaseComponentQuery
              def self.name = "ComponentBlocksPrimaryGlossaryTable"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
