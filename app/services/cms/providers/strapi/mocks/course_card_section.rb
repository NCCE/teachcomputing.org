module Cms
  module Providers
    module Strapi
      module Mocks
        class CourseCardSection < StrapiMock
          strapi_component "blocks.course-cards-section"

          attribute(:sectionTitle) { Faker::Lorem.sentence }
          attribute(:introText) { RichBlocks.generate_data }
          attribute(:cards) { Array.new(3) { DynamicComponents::CourseCard.generate_data } }
        end
      end
    end
  end
end
