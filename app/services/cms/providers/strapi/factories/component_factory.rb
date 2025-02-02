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
            when "content-blocks.enrol-button"
              DynamicComponents::EnrolButton.new(
                button_text: strapi_data[:buttonText],
                programme_slug: strapi_data[:programme][:data][:attributes][:slug]
              )
            when "content-blocks.file-link"
              file_data = strapi_data.dig(:file, :data) ? strapi_data[:file][:data][:attributes] : nil
              to_file(file_data) if file_data
            when "content-blocks.linked-picture"
              DynamicComponents::LinkedPicture.new(image: ModelFactory.to_image(strapi_data, :image), link: strapi_data[:link])
            when "content-blocks.link-with-icon"
              DynamicComponents::LinkWithIcon.new(
                url: strapi_data[:url],
                link_text: strapi_data[:linkText],
                icon: ModelFactory.to_image(strapi_data, :icon, default_size: :small)
              )
            when "blocks.text-with-asides"
              DynamicComponents::TextWithAsides.new(
                blocks: ModelFactory.to_content_block(strapi_data[:textContent], with_wrapper: false),
                asides: extract_aside_sections(strapi_data),
                background_color: extract_color_name(strapi_data, :bkColor)
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
            when "blocks.numeric-cards-section"
              to_card_wrapper(strapi_data, numeric_card_block(strapi_data[:numericCards]), title_as_paragraph: true)
            when "blocks.full-width-banner"
              to_full_width_banner(strapi_data)
            when "blocks.full-width-text"
              DynamicComponents::FullWidthText.new(
                blocks: ModelFactory.to_content_block(strapi_data[:textContent], with_wrapper: false),
                background_color: extract_color_name(strapi_data, :backgroundColor),
                show_bottom_border: strapi_data[:showBottomBorder]
              )
            when "blocks.testimonial-row"
              to_testimonial_row(strapi_data)
            when "content-blocks.testimonial"
              to_testimonial(strapi_data)
            when "blocks.numbered-icon-list"
              to_numbered_icon_list(strapi_data)
            when "blocks.split-horizontal-card"
              to_split_horizontal_card(strapi_data)
            when "blocks.community-activity-list"
              to_community_activity_list(strapi_data)
            when "blocks.sticky-dashboard-bar"
              DynamicComponents::StickyDashboardBar.new(programme_slug: strapi_data[:programme][:data][:attributes][:slug])
            when "blocks.enrolment-testimonial"
              to_enrolment_testimonial(strapi_data)
            when "blocks.enrolment-split-course-card"
              to_enrolment_split_course_card(strapi_data)
            end
          end

          def self.to_enrolment_split_course_card(strapi_data)
            DynamicComponents::EnrolmentSplitCourseCard.new(
              card_content: ModelFactory.to_content_block(strapi_data[:cardContent], with_wrapper: false),
              aside_content: ModelFactory.to_content_block(strapi_data[:asideContent], with_wrapper: false),
              enrol_aside: extract_aside_sections(strapi_data, param_name: :enrolAside),
              section_title: strapi_data[:sectionTitle],
              background_color: extract_color_name(strapi_data, :bkColor),
              color_theme: extract_color_name(strapi_data, :colorTheme),
              aside_title: strapi_data[:asideTitle],
              aside_icon: ModelFactory.to_image(strapi_data, :asideIcon),
              programme_slug: strapi_data[:programme][:data][:attributes][:slug]
            )
          end

          def self.to_enrolment_testimonial(strapi_data)
            DynamicComponents::EnrolmentTestimonial.new(
              title: strapi_data[:title],
              testimonial: to_testimonial(strapi_data[:testimonial]),
              enrolled_aside: extract_aside_sections(strapi_data, param_name: :enrolledAside),
              enrol_aside: extract_aside_sections(strapi_data, param_name: :enrolAside),
              background_color: extract_color_name(strapi_data, :bkColor),
              programme_slug: strapi_data[:programme][:data][:attributes][:slug]
            )
          end

          def self.to_community_activity_list(strapi_data)
            DynamicComponents::CommunityActivityGrid.new(
              title: strapi_data[:title],
              intro: ModelFactory.to_content_block(strapi_data[:intro], with_wrapper: false),
              programme_activity_group_slug: strapi_data[:group][:data][:attributes][:slug]
            )
          end

          def self.to_split_horizontal_card(strapi_data)
            DynamicComponents::SplitHorizontalCard.new(
              card_content: ModelFactory.to_content_block(strapi_data[:cardContent], with_wrapper: false),
              aside_content: ModelFactory.to_content_block(strapi_data[:asideContent], with_wrapper: false),
              aside_icon: ModelFactory.to_image(strapi_data, :asideIcon),
              aside_title: strapi_data[:asideTitle],
              section_title: strapi_data[:sectionTitle],
              color_theme: extract_color_name(strapi_data, :colorTheme),
              background_color: extract_color_name(strapi_data, :bkColor)
            )
          end

          def self.to_numbered_icon_list(strapi_data)
            DynamicComponents::NumberedIconList.new(
              title: strapi_data[:title],
              title_icon: ModelFactory.to_image(strapi_data, :titleIcon),
              points: strapi_data[:points].map { ModelFactory.to_content_block(_1[:textContent], with_wrapper: false) },
              aside_sections: extract_aside_sections(strapi_data)
            )
          end

          def self.to_testimonial_row(strapi_data)
            DynamicComponents::TestimonialRow.new(
              title: strapi_data[:title],
              background_color: extract_color_name(strapi_data, :backgroundColor),
              testimonials: strapi_data[:testimonials].map { to_testimonial(_1) }
            )
          end

          def self.to_testimonial(strapi_data)
            DynamicComponents::Testimonial.new(
              name: strapi_data[:name],
              job_title: strapi_data[:jobTitle],
              avatar: ModelFactory.to_image(strapi_data, :avatar, default_size: :small),
              quote: ModelFactory.to_content_block(strapi_data[:quote], with_wrapper: false)
            )
          end

          def self.to_horizontal_card(strapi_data)
            DynamicComponents::HorizontalCard.new(
              title: strapi_data[:title],
              body_blocks: ModelFactory.to_content_block(strapi_data[:textContent], with_wrapper: false),
              image: ModelFactory.to_image(strapi_data, :image, default_size: :small),
              image_link: strapi_data[:imageLink],
              color_theme: extract_color_name(strapi_data, :colorTheme),
              icon_block: icon_block(strapi_data[:iconBlock]),
              spacing: strapi_data[:spacing],
              external_title: strapi_data[:externalTitle]
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

          def self.extract_aside_sections(strapi_data, param_name: :asideSections)
            if strapi_data.dig(param_name, :data)
              Array.wrap(strapi_data[param_name][:data]).collect { _1[:attributes] }
            else
              []
            end
          end

          def self.extract_color_name(strapi_data, key)
            strapi_data[key][:data][:attributes][:name] if strapi_data.dig(key, :data)
          end

          def self.to_card_wrapper(strapi_data, cards_block, title_as_paragraph: false)
            DynamicComponents::CardWrapper.new(
              title: strapi_data[:sectionTitle],
              cards_block: cards_block,
              cards_per_row: strapi_data[:cardsPerRow],
              background_color: extract_color_name(strapi_data, :bkColor),
              title_as_paragraph:
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

          def self.numeric_card_block(strapi_data)
            strapi_data.map.with_index do |card_data, index|
              DynamicComponents::NumericCard.new(
                title: card_data[:title],
                text_content: ModelFactory.to_content_block(card_data[:textContent], with_wrapper: false, paragraph_class: "govuk-body-l"),
                number: index + 1
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
