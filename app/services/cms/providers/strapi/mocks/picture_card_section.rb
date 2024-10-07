module Cms
  module Providers
    module Strapi
      module Mocks
        class PictureCardSection
          def self.as_model(number_of_cards: 3, cards_per_row: 3, colour_scheme: nil)
            Factories::ComponentFactory.process_component(generate_raw_data(
              number_of_cards: number_of_cards,
              cards_per_row: cards_per_row,
              colour_scheme: colour_scheme
            ))
          end

          def self.generate_data(number_of_cards: 3, cards_per_row: 3, colour_scheme: nil)
            {
              sectionTitle: Faker::Lorem.words(number: 5),
              pictureCard: Array.new(number_of_cards) { PictureCard.generate_data(colour_scheme: colour_scheme) },
              cardsPerRow: cards_per_row,
              colourTheme: nil
            }
          end

          def self.generate_raw_data(number_of_cards: 3, cards_per_row: 3, colour_scheme: nil)
            {
              __component: "blocks.picture-card-section",
              id: 1
            }.merge(generate_data(
              number_of_cards: number_of_cards,
              cards_per_row: cards_per_row,
              colour_scheme: colour_scheme
            ))
          end
        end

        class PictureCard
          def self.as_model(colour_scheme: nil)
            Factories::ComponentFactory.picture_card_block(generate_data(colour_scheme: colour_scheme))
          end

          def self.generate_data(colour_scheme: nil)
            {
              title: Faker::Lorem.words(number: 5),
              image: {data: Image.generate_raw_data},
              bodyText: RichBlocks.generate,
              colourTheme: ColourScheme.generate_data(name: colour_scheme),
              link: Faker::Internet.url
            }
          end
        end
      end
    end
  end
end
