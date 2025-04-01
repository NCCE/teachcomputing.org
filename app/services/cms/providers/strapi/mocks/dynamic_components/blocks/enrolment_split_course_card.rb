module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class EnrolmentSplitCourseCard < StrapiMock
              strapi_component "blocks.enrolment-split-course-card"

              attribute(:cardContent) { [Cms::Mocks::TextBlock.generate_raw_data] }
              attribute(:asideContent) { [Cms::Mocks::TextBlock.generate_raw_data] }
              attribute(:enrolAside) { Cms::Mocks::AsideComponents::AsideSection.generate_aside_list(aside_slugs: ["enrolment-split-card-enrol-aside"]) }
              attribute(:sectionTitle) { Faker::Lorem.sentence }
              attribute(:bkColor) { ColorScheme.generate_data(name: "light-grey") }
              attribute(:colorTheme) { ColorScheme.generate_data(name: "standard") }
              attribute(:aside_title) { Faker::Lorem.sentence }
              attribute(:aside_icon) { Cms::Mocks::ImageComponents::Image.generate_raw_data }
              attribute(:programme) { {data: {attributes: {slug: "primary-certificate"}}} }
            end
          end
        end
      end
    end
  end
end
