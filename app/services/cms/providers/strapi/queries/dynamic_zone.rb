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
            Components::Blocks::QuestionAndAnswer
          ]

          def self.fields(name)
            <<~GRAPHQL.freeze
              #{name} {
                __typename
                #{COMPONENTS.map(&:fields).join("\n")}
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
