module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class SplitHorizontalCard < StrapiMock
              strapi_component "blocks.split-horizontal-card"

              attribute(:cardContent) { TextComponents::RichBlocks.generate_data }
              attribute(:asideContent) { TextComponents::RichBlocks.generate_data }
              attribute(:asideIcon) { {data: ImageComponents::Image.generate_raw_data} }
              attribute(:asideTitle) { Faker::Lorem.sentence }
              attribute(:sectionTitle) { Faker::Lorem.sentence }
              attribute(:colorTheme) { MetaComponents::ColorScheme.generate_data(name: "standard") }
              attribute(:backgroundColor) { MetaComponents::ColorScheme.generate_data(name: "light-grey") }
            end
          end
        end
      end
    end
  end
end
