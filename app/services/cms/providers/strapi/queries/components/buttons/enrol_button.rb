module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Buttons
            class EnrolButton < BaseComponentQuery
              def self.name = "ComponentButtonsEnrolButton"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{SharedFields.programme_slug}
                  loggedOutButtonText
                  loggedInButtonText
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
