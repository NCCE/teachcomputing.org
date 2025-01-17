module Cms
  module Providers
    module Strapi
      module Queries
        class PageTitle
          def self.fields(name)
            <<~GRAPHQL.freeze
              #{name} {
                title
                subText
                titleVideoUrl
                #{SharedFields.image_fields("titleImage")}
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
