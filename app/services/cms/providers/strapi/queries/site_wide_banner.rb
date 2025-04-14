module Cms
  module Providers
    module Strapi
      module Queries
        class SiteWideBanner
          def self.embed(name)
            <<~GRAPHQL.freeze
              textContent
            GRAPHQL
          end
        end
      end
    end
  end
end
