module Cms
  module Providers
    module Strapi
      module Queries
        class WebPagePreview
          def self.embed(_name)
            <<~GRAPHQL.freeze
              slug
              #{Seo.embed(:seo)}
            GRAPHQL
          end
        end
      end
    end
  end
end
