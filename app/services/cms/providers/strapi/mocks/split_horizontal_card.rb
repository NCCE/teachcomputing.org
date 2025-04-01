module Cms
  module Providers
    module Strapi
      module Mocks
        class SplitHorizontalCard < StrapiMock
          strapi_component "blocks.split-horizontal-card"

          attribute(:cardContent) { Cms::Mocks::RichBlocks.generate_data }
          attribute(:asideContent) { Cms::Mocks::RichBlocks.generate_data }
          attribute(:asideIcon) { {data: Cms::Mocks::ImageComponents::Image.generate_raw_data} }
          attribute(:asideTitle) { Faker::Lorem.sentence }
          attribute(:sectionTitle) { Faker::Lorem.sentence }
          attribute(:colorTheme) { ColorScheme.generate_data(name: "standard") }
          attribute(:backgroundColor) { ColorScheme.generate_data(name: "light-grey") }
        end
      end
    end
  end
end
