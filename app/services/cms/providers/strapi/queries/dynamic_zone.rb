module Cms
  module Providers
    module Strapi
      module Queries
        class DynamicZone
          COMPONENTS = [
            Components::Blocks::CommunityActivityList,
            Components::Blocks::CourseCardsSection,
            Components::Blocks::EnrolmentSplitCourseCard,
            Components::Blocks::EnrolmentTestimonial,
            Components::Blocks::FullWidthBanner,
            Components::Blocks::FullWidthText,
            Components::Blocks::HorizontalCard,
            Components::Blocks::IconRow,
            Components::Blocks::NumberedIconList,
            Components::Blocks::NumericCardsSection,
            Components::Blocks::PictureCardSection,
            Components::Blocks::QuestionAndAnswer,
            Components::Blocks::ResourceCardSection,
            Components::Blocks::SplitHorizontalCard,
            Components::Blocks::StickyDashboardBar,
            Components::Blocks::TestimonialRow,
            Components::Blocks::TextWithAsides
          ]

          def self.embed(name)
            <<~GRAPHQL.freeze
              #{name} {
                __typename
                #{COMPONENTS.map(&:fragment).join("\n")}
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
