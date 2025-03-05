module Cms
  module Providers
    module Strapi
      module Mocks
        module EmailComponents
          class CourseList < StrapiMock
            strapi_component "email-content.course-list"

            attribute(:sectionTitle) { Faker::Lorem.sentence }
            attribute(:removeOnMatch) { false }
            attribute(:courses) {
              Array.new(3) { Course.generate_data }
            }
          end

          class Course < StrapiMock
            attribute(:activityCode) { "CP428" }
            attribute(:displayName) { nil }
            attribute(:substitute) { false }
          end
        end
      end
    end
  end
end
