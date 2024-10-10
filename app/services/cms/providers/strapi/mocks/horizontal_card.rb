module Cms
  module Providers
    module Strapi
      module Mocks
        class HorizontalCard
          def self.as_model
            Factories::ComponentFactory.to_horizontal_card(generate_data)
          end

          def self.generate_data
            {
              title: Faker::Lorem.words(number: 5),
              bodyText: RichBlocks.generate_data,
              image: Image.generate_data,
              imageLink: nil,
              colourTheme: nil,
              iconBlock: IconBlocks.generate_data
            }
          end

          def self.generate_raw_data
            {
              __component: "blocks.horizontal-card",
              id: 1
            }.merge(generate_data)
          end
        end
      end
    end
  end
end
