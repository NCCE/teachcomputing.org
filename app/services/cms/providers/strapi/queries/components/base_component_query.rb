module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          class BaseComponentQuery
            def self.fields(name, fields)
              <<~GRAPHQL.freeze
                ... on #{name} {
                  #{fields}
                }
              GRAPHQL
            end
          end
        end
      end
    end
  end
end
