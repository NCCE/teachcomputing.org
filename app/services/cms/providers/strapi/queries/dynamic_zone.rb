module Cms
  module Providers
    module Strapi
      module Queries
        class DynamicZone
          COMPONENTS = [
            Components::Blocks::CommunityActivityList,
            Components::Blocks::TextWithAsides,
            Components::Blocks::HorizontalCard,
            Components::Blocks::FullWidthText,
            Components::Blocks::PictureCardSection,
            Components::Blocks::QuestionAndAnswer,
            Components::Blocks::ResourceCardSection,
            Components::Blocks::FullWidthBanner,
            Components::Blocks::TestimonialRow,
            Components::Blocks::NumericCardsSection,
            Components::Blocks::NumberedIconList,
            Components::Blocks::SplitHorizontalCard,
            Components::Blocks::StickyDashboardBar,
            Components::Blocks::EnrolmentTestimonial,
            Components::Blocks::EnrolmentSplitCourseCard,
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
