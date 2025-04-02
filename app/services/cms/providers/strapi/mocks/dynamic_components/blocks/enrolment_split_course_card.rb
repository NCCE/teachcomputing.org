module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class EnrolmentSplitCourseCard < StrapiMock
              strapi_component "blocks.enrolment-split-course-card"

              attribute(:cardContent) { [TextComponents::TextBlock.generate_raw_data] }
              attribute(:asideContent) { [TextComponents::TextBlock.generate_raw_data] }
              attribute(:enrolAside) { Collections::AsideSection.generate_aside_list(aside_slugs: ["enrolment-split-card-enrol-aside"]) }
              attribute(:sectionTitle) { Faker::Lorem.sentence }
              attribute(:bkColor) { MetaComponents::ColorScheme.generate_data(name: "light-grey") }
              attribute(:colorTheme) { MetaComponents::ColorScheme.generate_data(name: "standard") }
              attribute(:aside_title) { Faker::Lorem.sentence }
              attribute(:aside_icon) { ImageComponents::Image.generate_raw_data }
              attribute(:programme) { {data: {attributes: {slug: "primary-certificate"}}} }
            end
          end
        end
      end
    end
  end
end
