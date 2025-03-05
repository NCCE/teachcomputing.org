module Cms
  module Providers
    module Strapi
      module Queries
        class HeaderMenu
          def self.embed(name)
            <<~GRAPHQL.freeze
              #{name} {
                label
                menuItems {
                  label
                  url
                }
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
