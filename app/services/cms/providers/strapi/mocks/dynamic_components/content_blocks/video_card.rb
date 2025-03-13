module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class VideoCard < StrapiMock
              strapi_component "blocks.video-card"

              attribute(:videoUrl) { "https://www.youtube.com/watch?v=t0ojrm0fMoE&t" }
              attribute(:title) { Faker::Lorem.words(number: 3).join(" ") }
              attribute(:name) { Faker::Name.name }
              attribute(:jobTitle) { Faker::Company.department }
              attribute(:textContent) { Mocks::RichBlocks.generate_data }
              attribute(:colorTheme) { ColorScheme.generate_data(name: "standard") }
            end
          end
        end
      end
    end
  end
end
