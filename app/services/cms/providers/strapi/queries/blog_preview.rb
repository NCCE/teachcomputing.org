module Cms
  module Providers
    module Strapi
      module Queries
        class BlogPreview
          def self.embed(_name)
            <<~GRAPHQL.freeze
              #{SharedFields.image_fields("featuredImage")}
              title
              excerpt
              publishDate
              slug
            GRAPHQL
          end
        end
      end
    end
  end
end
