module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          class CourseCard < StrapiMock
            strapi_component "content-blocks.course-card"

            attribute(:title) { Faker::Lorem.words(number: 5).join(" ") }
            attribute(:bannerText) { Faker::Lorem.words(number: 3).join(" ") }
            attribute(:image) { Image.generate_data }
            attribute(:description) { RichBlocks.generate_data }
            attribute(:courseCode) { "CP199" }
          end
        end
      end
    end
  end
end
