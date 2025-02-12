module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class CourseCard < BaseComponentQuery
              def self.name = "ComponentContentBlocksCourseCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  bannerText
                  courseCode
                  description
                  #{SharedFields.image_fields(:image)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
