module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          class BaseComponentQuery
            def self.name
              raise NotImplementedError
            end

            def self.base_fields
              raise NotImplementedError
            end

            def self.embed(embed_name)
              <<~GRAPHQL.freeze
                #{embed_name} {
                  #{base_fields}
                }
              GRAPHQL
            end

            def self.fragment
              <<~GRAPHQL.freeze
                ... on #{name} {
                  #{base_fields}
                }
              GRAPHQL
            end
          end
        end
      end
    end
  end
end
