module Cms
  module Providers
    module Strapi
      module Queries
        class DynamicZone
          COMPONENTS = [
            Components::Blocks::ButtonBlock,
            Components::Blocks::CommunityActivityList,
            Components::Blocks::CourseCardsSection,
            Components::Blocks::CurriculumKeyStages,
            Components::Blocks::EnrolmentSplitCourseCard,
            Components::Blocks::EnrolmentTestimonial,
            Components::Blocks::FeedbackBanner,
            Components::Blocks::FullWidthBanner,
            Components::Blocks::FullWidthImageBanner,
            Components::Blocks::FullWidthText,
            Components::Blocks::HorizontalCard,
            Components::Blocks::HorizontalCardWithAsides,
            Components::Blocks::IconRow,
            Components::Blocks::NumberedIconList,
            Components::Blocks::NumericCardsSection,
            Components::Blocks::PictureCardSection,
            Components::Blocks::PrimaryGlossaryTable,
            Components::Blocks::ProgrammePictureCardSection,
            Components::Blocks::QuestionAndAnswer,
            Components::Blocks::ResourceCardSection,
            Components::Blocks::SecondaryQuestionBank,
            Components::Blocks::SplitHorizontalCard,
            Components::Blocks::StickyDashboardBar,
            Components::Blocks::TestimonialRow,
            Components::Blocks::TextWithAsides,
            Components::Blocks::TextWithTestimonial,
            Components::Blocks::TwoColumnPictureSection,
            Components::Blocks::TwoColumnVideoSection,
            Components::Blocks::VideoCardsSection
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
