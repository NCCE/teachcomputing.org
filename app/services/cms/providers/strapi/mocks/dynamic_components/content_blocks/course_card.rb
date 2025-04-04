module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class CourseCard < StrapiMock
              strapi_component "content-blocks.course-card"

              attribute(:title) { Faker::Lorem.words(number: 5).join(" ") }
              attribute(:bannerText) { Faker::Lorem.words(number: 3).join(" ") }
              attribute(:image) { Images::Image.generate_data }
              attribute(:description) { Text::RichBlocks.generate_data }
              attribute(:courseCode) { "CP199" }
            end
          end
        end
      end
    end
  end
end
