module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class EnrolmentSplitCourseCard < BaseComponentQuery
              def self.name = "ComponentBlocksEnrolmentSplitCourseCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  esc_cardContent: cardContent
                  esc_asideContent: asideContent
                  sectionTitle
                  #{SharedFields.color_theme(:bkColor)}
                  #{SharedFields.color_theme(:colorTheme)}
                  asideTitle
                  #{SharedFields.image_fields(:asideIcon)}
                  #{SharedFields.aside_sections(:enrolAside)}
                  #{SharedFields.programme_slug}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
