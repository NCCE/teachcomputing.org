module Cms
  module Providers
    module Strapi
      module Mocks
        class ResourceCard
          def self.generate(card_count = 3)
            Array.new(card_count) do
              Models::ResourceCard.new(
                title: Faker::Lorem.sentence,
                icon: Cms::Mocks::Image.as_model,
                colour_theme: Faker::Lorem.word,
                body_text: Cms::Mocks::RichBlocks.generate,
                button_text: Faker::Lorem.word,
                button_link: Faker::Internet.url
              )
            end
          end
        end
      end
    end
  end
end
