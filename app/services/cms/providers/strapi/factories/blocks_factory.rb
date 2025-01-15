module Cms
  module Providers
    module Strapi
      module Factories
        module BlocksFactory
          include BaseFactory

          def self.generate_component(component_name, strapi_data)
            case component_name
            when "full-width-banner"
              to_full_width_banner(strapi_data)
            when "full-width-text"
              to_full_width_text(strapi_data)
            when "horizontal-card"
              to_horizontal_card(strapi_data)
            when "numbered-icon-list"
              to_numbered_icon_list(strapi_data)
            when "numeric-cards-section"
              to_card_wrapper(strapi_data, to_numeric_card_block(strapi_data[:numericCards]))
            when "picture-card-section"
              to_card_wrapper(strapi_data, to_picture_card_block(strapi_data[:pictureCards]))
            when "question-and-answer"
              to_question_and_answer(strapi_data)
            when "resource-card-section"
              to_card_wrapper(strapi_data, to_resource_card_block(strapi_data[:resourceCards]))
            when "split-horizontal-card"
              to_split_horizontal_card(strapi_data)
            when "testimonial-row"
              to_testimonial_row(strapi_data)
            when "text-with-asides"
              to_text_with_asides(strapi_data)
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

          def self.to_icon_block(strapi_data)
            DynamicComponents::IconBlock.new(icons: strapi_data.map { to_icon(_1) })
          end

          def self.to_numeric_card_block(strapi_data)
            strapi_data.map.with_index do |card_data, index|
              DynamicComponents::NumericCard.new(
                title: card_data[:title],
                text_content: to_content_block(card_data[:textContent], with_wrapper: false, paragraph_class: "govuk-body-l"),
                number: index + 1
              )
            end
          end

          def self.to_picture_card_block(strapi_data)
            strapi_data.map do |card_data|
              DynamicComponents::PictureCard.new(
                image: to_image(card_data, :image, default_size: :medium),
                title: card_data[:title],
                body_text: to_content_block(card_data[:textContent], with_wrapper: false),
                link: card_data[:link],
                color_theme: extract_color_name(card_data, :colorTheme)
              )
            end
          end

          def self.to_resource_card_block(strapi_data)
            strapi_data.map do |card_data|
              DynamicComponents::ResourceCard.new(
                title: card_data[:title],
                icon: to_image(card_data, :icon, default_size: :medium),
                color_theme: extract_color_name(card_data, :colorTheme),
                body_text: to_content_block(card_data[:textContent], with_wrapper: false),
                button_text: card_data[:buttonText],
                button_link: card_data[:buttonLink]
              )
            end
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

          def self.to_full_width_banner(strapi_data)
            DynamicComponents::FullWidthBanner.new(
              text_content: to_content_block(strapi_data[:textContent], with_wrapper: false),
              background_color: extract_color_name(strapi_data, :backgroundColor),
              image: to_image(strapi_data, :image, default_size: :medium),
              image_side: strapi_data[:imageSide],
              image_link: strapi_data[:imageLink],
              buttons: strapi_data[:buttons] ? strapi_data[:buttons].map { to_ncce_button(_1) } : [],
              title: strapi_data[:sectionTitle],
              show_bottom_border: strapi_data[:showBottomBorder]
            )
          end

          def self.to_full_width_text(strapi_data)
            DynamicComponents::FullWidthText.new(
              blocks: to_content_block(strapi_data[:textContent], with_wrapper: false),
              background_color: extract_color_name(strapi_data, :backgroundColor),
              show_bottom_border: strapi_data[:showBottomBorder]
            )
          end

          def self.to_horizontal_card(strapi_data)
            DynamicComponents::HorizontalCard.new(
              title: strapi_data[:title],
              body_blocks: to_content_block(strapi_data[:textContent], with_wrapper: false),
              image: to_image(strapi_data, :image, default_size: :small),
              image_link: strapi_data[:imageLink],
              color_theme: extract_color_name(strapi_data, :colorTheme),
              icon_block: to_icon_block(strapi_data[:iconBlock]),
              spacing: strapi_data[:spacing],
              external_title: strapi_data[:externalTitle]
            )
          end

          def self.to_numbered_icon_list(strapi_data)
            DynamicComponents::NumberedIconList.new(
              title: strapi_data[:title],
              title_icon: to_image(strapi_data, :titleIcon),
              points: strapi_data[:points].map { to_content_block(_1[:textContent], with_wrapper: false) },
              aside_sections: extract_aside_sections(strapi_data)
            )
          end

          def self.to_question_and_answer(strapi_data)
            DynamicComponents::QuestionAndAnswer.new(
              question: strapi_data[:question],
              answer: to_content_block(strapi_data[:answer], with_wrapper: false),
              aside_sections: extract_aside_sections(strapi_data),
              answer_icon_block: to_icon_block(strapi_data[:answerIcons]),
              aside_alignment: strapi_data[:asideAlignment],
              show_background_triangle: strapi_data[:showBackgroundTriangle]
            )
          end

          def self.to_split_horizontal_card(strapi_data)
            DynamicComponents::SplitHorizontalCard.new(
              card_content: to_content_block(strapi_data[:cardContent], with_wrapper: false),
              aside_content: to_content_block(strapi_data[:asideContent], with_wrapper: false),
              aside_icon: to_image(strapi_data, :asideIcon),
              aside_title: strapi_data[:asideTitle],
              section_title: strapi_data[:sectionTitle],
              color_theme: extract_color_name(strapi_data, :colorTheme),
              background_color: extract_color_name(strapi_data, :bkColor)
            )
          end

          def self.to_testimonial_row(strapi_data)
            DynamicComponents::TestimonialRow.new(
              title: strapi_data[:title],
              background_color: extract_color_name(strapi_data, :backgroundColor),
              testimonials: strapi_data[:testimonials].map { to_testimonial(_1) }
            )
          end

          def self.to_text_with_asides(strapi_data)
            DynamicComponents::TextWithAsides.new(
              blocks: to_content_block(strapi_data[:textContent], with_wrapper: false),
              asides: extract_aside_sections(strapi_data),
              background_color: extract_color_name(strapi_data, :bkColor)
            )
          end
        end
      end
    end
  end
end
