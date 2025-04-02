module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class PictureCard < StrapiMock
              attribute(:title) { Faker::Lorem.words(number: 5).join(" ") }
              attribute(:image) { {data: ImageComponents::Image.generate_raw_data} }
              attribute(:textContent) { TextComponents::RichBlocks.generate_data }
              attribute(:colorTheme) { {data: MetaComponents::ColorScheme.generate_data(name: "standard")} }
              attribute(:link) { Faker::Internet.url }
            end
          end
        end
      end
    end
  end
end
