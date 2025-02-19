module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module EmailContent
            class Course < BaseComponentQuery
              def self.name = "ComponentEmailContentCourse"

              def self.base_fields
                <<~GRAPHQL.freeze
                  displayName
                  substitute
                  activityCode
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
