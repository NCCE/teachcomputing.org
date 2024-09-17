module Cms
  module Providers
    module Strapi
      module Mocks
        class IconBlocks
          def self.generate(icon_count = 1)
            Cms::DynamicComponents::IconBlock.new(
              icons: Array.new(icon_count) do
                Cms::DynamicComponents::Icon.new(
                  text: Faker::Lorem.word,
                  image: Cms::Mocks::Image.as_model
                )
              end
            )
          end
        end
      end
    end
  end
end
