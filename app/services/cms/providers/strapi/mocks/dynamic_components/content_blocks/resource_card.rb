module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class ResourceCard < StrapiMock
              attribute(:title) { Faker::Lorem.words(number: 5).join(" ") }
              attribute(:icon) { nil }
              attribute(:textContent) { RichBlocks.generate_data }
              attribute(:colorTheme) { {data: ColorScheme.generate_data(name: "standard")} }
              attribute(:buttonText) { nil }
              attribute(:buttonLink) { nil }
            end
          end
        end
      end
    end
  end
end
