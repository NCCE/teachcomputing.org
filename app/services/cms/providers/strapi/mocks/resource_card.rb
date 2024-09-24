module Cms
  module Providers
    module Strapi
      module Mocks
        class ResourceCard
          def self.generate(
            card_count: 3,
            title: nil,
            icon: nil,
            colour_theme: nil,
            button_text: nil,
            button_link: nil
          )
            Array.new(card_count) do
              Models::ResourceCard.new(
                title: title,
                icon: icon,
                colour_theme: colour_theme,
                body_text: Cms::Mocks::RichBlocks.generate,
                button_text: button_text,
                button_link: button_link
              )
            end
          end
        end
      end
    end
  end
end
