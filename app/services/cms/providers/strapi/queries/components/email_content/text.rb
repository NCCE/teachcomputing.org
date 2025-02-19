module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module EmailContent
            class Text < BaseComponentQuery
              def self.name = "ComponentEmailContentText"

              def self.base_fields
                <<~GRAPHQL.freeze
                  textContent
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
