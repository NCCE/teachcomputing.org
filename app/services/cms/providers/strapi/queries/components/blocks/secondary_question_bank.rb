module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class SecondaryQuestionBank < BaseComponentQuery
              def self.name = "ComponentBlocksSecondaryQuestionBank"

              def self.base_fields
                <<~GRAPHQL.freeze
                  sqb__title: title
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
