module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module EmailContent
            class CourseList < BaseComponentQuery
              def self.name = "ComponentEmailContentCourseList"

              def self.base_fields
                <<~GRAPHQL.freeze
                  sectionTitle
                  #{Course.embed("courses")}
                  removeOnMatch
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
