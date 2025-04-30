module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class ProgrammeResourceCard < BaseComponentQuery
              def self.name = "ComponentProgResourceCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  loggedOutTextContent
                  notEnrolledTextContent
                  enrolledTextContent
                  loggedOutButtonText
                  loggedInButtonText
                  #{SharedFields.color_theme(:clrTheme)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
