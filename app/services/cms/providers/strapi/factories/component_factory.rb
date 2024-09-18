module Cms
  module Providers
    module Strapi
      module Factories
        module ComponentFactory
          def self.process_component(strapi_data)
            component_name = strapi_data[:__component]
            case component_name
            when "content-blocks.text-block"
              ModelFactory.to_content_block(strapi_data[:content], with_wrapper: false)
            when "content-blocks.file-link"
              file_data = strapi_data.dig(:file, :data) ? strapi_data[:file][:data][:attributes] : nil
              to_file(file_data) if file_data
            when "blocks.text-with-asides"
              asides = if strapi_data.dig(:asideSections, :data)
                strapi_data[:asideSections][:data].collect { _1[:attributes] }
              else
                []
              end
              DynamicComponents::TextWithAsides.new(blocks: strapi_data[:textContent], asides:)
            when "blocks.horizontal-card"
              DynamicComponents::HorizontalCard.new(
                title: strapi_data[:title],
                body_blocks: strapi_data[:bodyText],
                image: strapi_data.dig(:image, :data) ? ModelFactory.to_image(strapi_data[:image][:data][:attributes], default_size: :small) : nil,
                image_link: strapi_data[:imageLink],
                colour_theme: strapi_data.dig(:colourTheme, :data) ? strapi_data[:colourTheme][:data][:attributes][:name] : nil,
                icon_block: icon_block(strapi_data[:iconBlock])
              )
            when "buttons.ncce-button"
              DynamicComponents::NcceButton.new(title: strapi_data[:title], link: strapi_data[:link])
            when "blocks.question-and-answer"
              to_question_and_answer(strapi_data)
            when "blocks.card-section"
              DynamicComponents::CardWrapper.new(
                title: strapi_data[:sectionTitle],
                cards_block: resource_card_block(strapi_data[:resourceCard]),
                cards_per_row: strapi_data[:cardsPerRow],
                background_color: strapi_data.dig(:backgroundColour, :data) ? strapi_data[:backgroundColour][:data][:attributes][:name] : nil
              )
            when "blocks.full-width-banner"
              DynamicComponents::FullWidthBanner.new(
                text_content: ModelFactory.to_content_block(strapi_data[:textContent]),
                background_color: strapi_data[:backgroundColor][:name],
                image: ModelFactory.to_image(strapi_data[:image]),
                image_side: strapi_data[:image_side],
                image_link: strapi_data[:imageLink],
                buttons: [] # TODO pull from Q&A branch,
              )
            end
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

          def self.resource_card_block(strapi_data)
            strapi_data.map do |card_data|
              Models::ResourceCard.new(
                title: card_data[:title],
                icon: card_data.dig(:icon, :data) ? ModelFactory.to_image(card_data[:icon][:data][:attributes]) : nil,
                colour_theme: card_data.dig(:colourTheme, :data) ? card_data[:colourTheme][:data][:attributes][:name] : nil,
                body_text: card_data[:bodyText],
                button_text: card_data[:buttonText],
                button_link: card_data[:buttonLink]
              )
            end
          end

          def self.icon_block(strapi_data)
            DynamicComponents::IconBlock.new(icons: strapi_data.map { icon(_1) })
          end

          def self.icon(icon_data)
            DynamicComponents::Icon.new(
              text: icon_data[:iconText],
              image: ModelFactory.to_image(icon_data[:iconImage][:data][:attributes])
            )
          end

          def self.to_file(data)
            Models::File.new(
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
