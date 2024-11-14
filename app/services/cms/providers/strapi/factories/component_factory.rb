module Cms
  module Providers
    module Strapi
      module Factories
        module ComponentFactory
          def self.process_component(strapi_data)
            component_name = strapi_data[:__component]
            case component_name
            when "content-blocks.text-block"
              ModelFactory.to_content_block(strapi_data[:textContent], with_wrapper: false)
            when "content-blocks.file-link"
              file_data = strapi_data.dig(:file, :data) ? strapi_data[:file][:data][:attributes] : nil
              to_file(file_data) if file_data
            when "content-blocks.linked-picture"
              DynamicComponents::LinkedPicture.new(image: ModelFactory.to_image(strapi_data, :image), link: strapi_data[:link])
            when "blocks.text-with-asides"
              DynamicComponents::TextWithAsides.new(
                blocks: ModelFactory.to_content_block(strapi_data[:textContent], with_wrapper: false),
                asides: extract_aside_sections(strapi_data)
              )
            when "blocks.horizontal-card"
              to_horizontal_card(strapi_data)
            when "buttons.ncce-button"
              to_ncce_button(strapi_data)
            when "blocks.question-and-answer"
              to_question_and_answer(strapi_data)
            when "blocks.resource-card-section"
              to_card_wrapper(strapi_data, resource_card_block(strapi_data[:resourceCards]))
            when "blocks.picture-card-section"
              to_card_wrapper(strapi_data, picture_card_block(strapi_data[:pictureCards]))
            when "blocks.full-width-banner"
              to_full_width_banner(strapi_data)
            when "blocks.full-width-text"
              DynamicComponents::FullWidthText.new(
                blocks: ModelFactory.to_content_block(strapi_data[:textContent], with_wrapper: false),
                background_color: extract_color_name(strapi_data, :backgroundColor),
                show_bottom_border: strapi_data[:showBottomBorder]
              )
            end
          end

          def self.to_horizontal_card(strapi_data)
            DynamicComponents::HorizontalCard.new(
              title: strapi_data[:title],
              body_blocks: strapi_data[:textContent],
              image: ModelFactory.to_image(strapi_data, :image, default_size: :small),
              image_link: strapi_data[:imageLink],
              color_theme: extract_color_name(strapi_data, :colorTheme),
              icon_block: icon_block(strapi_data[:iconBlock]),
              spacing: strapi_data[:spacing]
            )
          end

          def self.to_full_width_banner(strapi_data)
            DynamicComponents::FullWidthBanner.new(
              text_content: ModelFactory.to_content_block(strapi_data[:textContent], with_wrapper: false),
              background_color: extract_color_name(strapi_data, :backgroundColor),
              image: ModelFactory.to_image(strapi_data, :image, default_size: :medium),
              image_side: strapi_data[:imageSide],
              image_link: strapi_data[:imageLink],
              buttons: strapi_data[:buttons] ? strapi_data[:buttons].map { to_ncce_button(_1) } : [],
              title: strapi_data[:sectionTitle],
              show_bottom_border: strapi_data[:showBottomBorder]
            )
          end

          def self.to_ncce_button(strapi_data)
            DynamicComponents::NcceButton.new(title: strapi_data[:title], link: strapi_data[:link], color: strapi_data[:buttonTheme])
          end

          def self.to_question_and_answer(strapi_data)
            DynamicComponents::QuestionAndAnswer.new(
              question: strapi_data[:question],
              answer: ModelFactory.to_content_block(strapi_data[:answer], with_wrapper: false),
              aside_sections: extract_aside_sections(strapi_data),
              answer_icon_block: icon_block(strapi_data[:answerIcons]),
              aside_alignment: strapi_data[:asideAlignment],
              show_background_triangle: strapi_data[:showBackgroundTriangle]
            )
          end

          def self.extract_aside_sections(strapi_data)
            if strapi_data.dig(:asideSections, :data)
              strapi_data[:asideSections][:data].collect { _1[:attributes] }
            else
              []
            end
          end

          def self.extract_color_name(strapi_data, key)
            strapi_data[key][:data][:attributes][:name] if strapi_data.dig(key, :data)
          end

          def self.to_card_wrapper(strapi_data, cards_block)
            DynamicComponents::CardWrapper.new(
              title: strapi_data[:sectionTitle],
              cards_block: cards_block,
              cards_per_row: strapi_data[:cardsPerRow],
              background_color: extract_color_name(strapi_data, :bkColor)
            )
          end

          def self.resource_card_block(strapi_data)
            strapi_data.map do |card_data|
              DynamicComponents::ResourceCard.new(
                title: card_data[:title],
                icon: ModelFactory.to_image(card_data, :icon, default_size: :medium),
                color_theme: extract_color_name(card_data, :colorTheme),
                body_text: ModelFactory.to_content_block(card_data[:textContent], with_wrapper: false),
                button_text: card_data[:buttonText],
                button_link: card_data[:buttonLink]
              )
            end
          end

          def self.picture_card_block(strapi_data)
            strapi_data.map do |card_data|
              DynamicComponents::PictureCard.new(
                image: ModelFactory.to_image(card_data, :image, default_size: :medium),
                title: card_data[:title],
                body_text: ModelFactory.to_content_block(card_data[:textContent], with_wrapper: false),
                link: card_data[:link],
                color_theme: extract_color_name(card_data, :colorTheme)
              )
            end
          end

          def self.icon_block(strapi_data)
            DynamicComponents::IconBlock.new(icons: strapi_data.map { icon(_1) })
          end

          def self.icon(icon_data)
            DynamicComponents::Icon.new(
              text: icon_data[:iconText],
              image: ModelFactory.to_image(icon_data, :iconImage, default_size: :small)
            )
          end

          def self.to_file(data)
            DynamicComponents::FileLink.new(
              url: data[:url],
              filename: data[:name],
              size: data[:size],
              updated_at: DateTime.parse(data[:updatedAt])
            )
          end
        end
      end
    end
  end
end
