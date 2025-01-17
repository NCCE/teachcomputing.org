module Cms
  module Providers
    module Strapi
      module Queries
        class Seo
          def self.fields(name)
            <<~GRAPHQL.freeze
              #{name} {
                id
                title
                description
                #{SharedFields.image_fields("featuredImage")}
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
