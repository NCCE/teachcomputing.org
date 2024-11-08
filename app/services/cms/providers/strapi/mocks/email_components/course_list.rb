module Cms
  module Providers
    module Strapi
      module Mocks
        module EmailComponents
          class CourseList < StrapiEmailMock
            strapi_component "email-content.course-list"

            attribute(:sectionTitle) { Faker::Lorem.sentence }
            attribute(:removeOnMatch) { false }
            attribute(:courses) {
              Array.new(3) { Course.generate_data }
            }
          end

          class Course < StrapiEmailMock
            attribute(:activityCode) { "CP428" }
            attribute(:displayName) { nil }
            attribute(:substitute) { false }
          end
        end
      end
    end
  end
end
