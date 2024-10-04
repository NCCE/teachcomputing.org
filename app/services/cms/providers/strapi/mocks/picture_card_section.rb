module Cms
  module Providers
    module Strapi
      module Mocks
        class PictureCardSection
          def self.as_model
            Factories::ComponentFactory.process_component(generate_raw_data)
          end

          def self.generate_data
            {
              sectionTitle: Faker::Lorem.words(number: 5),
              pictureCard: Array.new(3) { PictureCard.generate_data },
              cardsPerRow: 3,
              colourTheme: nil
            }
          end

          def self.generate_raw_data
            {
              __component: "blocks.picture-card-section",
              id: 1
            }.merge(generate_data)
          end
        end

        class PictureCard
          def self.as_model
            Factories::ComponentFactory.picture_card_block(generate_data)
          end

          def self.generate_data
            {
              title: Faker::Lorem.words(number: 5),
              image: {data: Image.generate_raw_data},
              bodyText: RichBlocks.generate,
              colourTheme: nil,
              link: Faker::Internet.url
            }
          end
        end
      end
    end
  end
end
