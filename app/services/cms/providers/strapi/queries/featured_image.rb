module Cms
  module Providers
    module Strapi
      module Queries
        class FeaturedImage
          def self.fields(name)
            <<~GRAPHQL.freeze
              #{SharedFields.image_fields(name)}
            GRAPHQL
          end
        end
      end
    end
  end
end
