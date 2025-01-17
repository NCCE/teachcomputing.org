module Cms
  module Providers
    module Strapi
      module Queries
        class SimpleField
          def self.fields(name)
            <<~GRAPHQL.freeze
              #{name}
            GRAPHQL
          end
        end
      end
    end
  end
end
