module Cms
  module Providers
    module Strapi
      module Queries
        class Slug
          def self.embed(_name)
            <<~GRAPHQL.freeze
              slug
            GRAPHQL
          end
        end
      end
    end
  end
end
