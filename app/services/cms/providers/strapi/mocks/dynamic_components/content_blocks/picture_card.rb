module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class PictureCard < StrapiMock
              attribute(:title) { Faker::Lorem.words(number: 5).join(" ") }
              attribute(:image) { {data: Images::Image.generate_raw_data} }
              attribute(:textContent) { Text::RichBlocks.generate_data }
              attribute(:colorTheme) { {data: Meta::ColorScheme.generate_data(name: "standard")} }
              attribute(:link) { Faker::Internet.url }
            end
          end
        end
      end
    end
  end
end
