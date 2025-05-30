module Cms
  module Providers
    module Strapi
      module Queries
        class FooterLinkBlock
          def self.embed(name)
            <<~GRAPHQL.freeze
              #{name} {
                link {
                  linkText
                  url
                  #{SharedFields.image_fields("icon")}
                }
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
