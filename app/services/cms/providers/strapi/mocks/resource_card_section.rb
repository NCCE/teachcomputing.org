module Cms
  module Providers
    module Strapi
      module Mocks
        class ResourceCardSection
          def self.as_model(
            number_of_cards: 3,
            cards_per_row: 3,
            colour_scheme: nil,
            button_text: nil,
            button_link: nil,
            icon: nil
          )

            Factories::ComponentFactory.process_component(generate_raw_data(
              number_of_cards: number_of_cards,
              cards_per_row: cards_per_row,
              colour_scheme: colour_scheme,
              button_text: button_text,
              button_link: button_link,
              icon: icon
            ))
          end

          def self.generate_data(
            number_of_cards: 3,
            cards_per_row: 3,
            colour_scheme: nil,
            button_text: nil,
            button_link: nil,
            icon: nil
          )
            {
              sectionTitle: Faker::Lorem.words(number: 5),
              resourceCard: Array.new(number_of_cards) {
                ResourceCard.generate_data(
                  colour_scheme: colour_scheme,
                  button_text: button_text,
                  button_link: button_link,
                  icon: icon
                )
              },
              cardsPerRow: cards_per_row,
              colourTheme: nil
            }
          end

          def self.generate_raw_data(
            number_of_cards: 3,
            cards_per_row: 3,
            colour_scheme: nil,
            button_text: nil,
            button_link: nil,
            icon: nil
          )
            {
              __component: "blocks.resource-card-section",
              id: 1
            }.merge(generate_data(
              number_of_cards: number_of_cards,
              cards_per_row: cards_per_row,
              colour_scheme: colour_scheme,
              button_text: button_text,
              button_link: button_link,
              icon: icon
            ))
          end
        end

        class ResourceCard
          def self.as_model(colour_scheme: nil, button_text: nil, button_link: nil, icon: nil)
            Factories::ComponentFactory.resource_card_block(generate_data(
              colour_scheme: colour_scheme,
              button_text: button_text,
              button_link: button_link,
              icon: icon
            ))
          end

          def self.generate_data(colour_scheme: nil, button_text: nil, button_link: nil, icon: nil)
            {
              title: Faker::Lorem.words(number: 5),
              icon: icon,
              bodyText: RichBlocks.generate_data,
              colourTheme: {data: ColourScheme.generate_data(name: colour_scheme)},
              buttonText: button_text,
              buttonLink: button_link
            }
          end
        end
      end
    end
  end
end
