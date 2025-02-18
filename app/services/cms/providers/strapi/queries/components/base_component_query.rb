module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          class BaseComponentQuery
            class << self
              def name
                raise NotImplementedError
              end

              def base_fields
                raise NotImplementedError
              end

              def embed(embed_name)
                <<~GRAPHQL.freeze
                  #{embed_name} {
                    #{base_fields}
                  }
                GRAPHQL
              end

              def fragment
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
end
