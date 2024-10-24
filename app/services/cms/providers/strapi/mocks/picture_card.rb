module Cms
  module Providers
    module Strapi
      module Mocks
        class PictureCard < StrapiMock
          attribute(:title) { Faker::Lorem.words(number: 5).join(" ") }
          attribute(:image) { {data: Image.generate_raw_data} }
          attribute(:textContent) { RichBlocks.generate_data }
          attribute(:colorTheme) { ColorScheme.generate_data(name: "standard") }
          attribute(:link) { Faker::Internet.url }
        end
      end
    end
  end
end
