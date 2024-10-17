module Cms
  module Providers
    module Strapi
      module Mocks
        class Image
          SIZES = {
            medium: [750, 500],
            small: [500, 300],
            thumbnail: [250, 100]
          }

          def self.as_model
            Factories::ModelFactory.as_image(generate_data)
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
              url: Faker::LoremFlickr.image(size: "1000x800")
            }
          end

          def self.format(name, hash_name, size)
            {
              ext: ".png",
              url: Faker::LoremFlickr.image(size: SIZES[size].join("x")),
              hash: hash_name,
              mime: "image/png",
              name: name,
              size: 390.03,
              width: SIZES[size][0],
              height: SIZES[size][1],
              sizeInBytes: 390028
            }
          end
        end
      end
    end
  end
end
