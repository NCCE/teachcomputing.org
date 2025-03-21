module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Buttons
            class NcceButton < BaseComponentQuery
              def self.name = "ComponentButtonsNcceButton"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  ncceButton__link: link
                  buttonTheme
                  loggedInTitle
                  loggedInLink
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
