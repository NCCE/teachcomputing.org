module Cms
  module Providers
    module Strapi
      module Mocks
        class IconBlocks
          def self.as_model(icon_count: 1)
            Factories::ComponentFactory.icon_block(generate_data(icon_count:))
          end

          def self.generate_data(icon_count: 1)
            Array.new(icon_count) { Icon.generate_data }
          end
        end

        class Icon
          def self.as_model
            Factories::ComponentFactory.icon(generate_data)
          end

          def self.generate_data
            {
              iconText: Faker::Lorem.word,
              iconImage: {data: Image.generate_raw_data}
            }
          end
        end
      end
    end
  end
end