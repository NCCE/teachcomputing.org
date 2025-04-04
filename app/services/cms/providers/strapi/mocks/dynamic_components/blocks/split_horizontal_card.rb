module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class SplitHorizontalCard < StrapiMock
              strapi_component "blocks.split-horizontal-card"

              attribute(:cardContent) { Text::RichBlocks.generate_data }
              attribute(:asideContent) { Text::RichBlocks.generate_data }
              attribute(:asideIcon) { {data: Images::Image.generate_raw_data} }
              attribute(:asideTitle) { Faker::Lorem.sentence }
              attribute(:sectionTitle) { Faker::Lorem.sentence }
              attribute(:colorTheme) { Meta::ColorScheme.generate_data(name: "standard") }
              attribute(:backgroundColor) { Meta::ColorScheme.generate_data(name: "light-grey") }
            end
          end
        end
      end
    end
  end
end
