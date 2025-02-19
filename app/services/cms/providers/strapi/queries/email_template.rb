module Cms
  module Providers
    module Strapi
      module Queries
        class EmailTemplate
          COMPONENTS = [
            Components::EmailContent::CourseList,
            Components::EmailContent::Cta,
            Components::EmailContent::Text
          ]

          def self.embed(_name)
            <<~GRAPHQL.freeze
              name
              slug
              subject
              active
              #{SharedFields.programme_slug}
              #{SharedFields.by_slug("completedGroupings")}
              activityState
              enrolled
              emailContent {
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
