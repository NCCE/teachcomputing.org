module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class ProgrammePictureCard < BaseComponentQuery
              def self.name = "ComponentProgrammePictureCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  textContent
                  #{SharedFields.image_fields(:image)}
                  loggedOutLinkTitle
                  loggedOutLink
                  enrolledLinkTitle
                  enrolledLink
                  notEnrolledLinkTitle
                  notEnrolledLink
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
