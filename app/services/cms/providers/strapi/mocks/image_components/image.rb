module Cms
  module Providers
    module Strapi
      module Mocks
        module ImageComponents
          class Image
            include ActionView::Helpers::AssetUrlHelper

            SIZES = {
              large: {
                size: [1000, 800],
                url: "/test-images/large_test.png"
              },
              medium: {
                size: [750, 500],
                url: "/test-images/medium_test.png"
              },
              small: {
                size: [500, 300],
                url: "/test-images/small_test.png"
              },
              thumbnail: {
                size: [250, 100],
                url: "/test-images/thumbail_test.png"
              }
            }

            def self.as_model(caption: nil)
              Factories::ModelFactory.as_image(generate_data(caption:))
            end

            def self.generate_raw_data(caption: nil)
              {
                id: 1,
                attributes: generate_data
              }
            end

            def self.generate_data(caption: nil)
              name = Faker::Lorem.word
              filename = "#{name}.png"
              hash = Faker::Alphanumeric.alphanumeric(number: 10)
              hash_name = "#{name}_#{hash}"
              {
                name: filename,
                alternativeText: Faker::Lorem.sentence,
                caption: caption,
                width: 1000,
                height: 800,
                formats: {
                  medium: format(name, hash_name, :medium),
                  small: format(name, hash_name, :small),
                  thumbnail: format(name, hash_name, :thumbnail)
                },
                hash: hash_name,
                ext: ".png",
                mime: "image/png",
                size: 137.23,
                url: SIZES[:large][:url]
              }
            end

            def self.format(name, hash_name, size)
              {
                ext: ".png",
                url: SIZES[size][:url],
                hash: hash_name,
                mime: "image/png",
                name: name,
                size: 390.03,
                width: SIZES[size][:size][0],
                height: SIZES[size][:size][1],
                sizeInBytes: 390028
              }
            end
          end
        end
      end
    end
  end
end
