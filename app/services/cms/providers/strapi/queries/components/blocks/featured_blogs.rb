module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class FeaturedBlogs < BaseComponentQuery
              def self.name = "ComponentBlocksFeaturedBlogs"

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
