module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class EnrolButton < BaseComponentQuery
              def self.name = "ComponentContentBlocksEnrolButton"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{SharedFields.programme_slug}
                  buttonText
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
