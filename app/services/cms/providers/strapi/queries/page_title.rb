module Cms
  module Providers
    module Strapi
      module Queries
        class PageTitle
          def self.embed(name)
            <<~GRAPHQL.freeze
              #{name} {
                title
                subText
                titleVideoUrl
                #{SharedFields.image_fields("titleImage")}
                #{SharedFields.color_theme(:bkColor)}
                iBelongFlag
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
