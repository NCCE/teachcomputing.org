module Cms
  module Providers
    module Strapi
      module Queries
        class Aside
          CONTENT_COMPONENTS = [
            Components::ContentBlocks::EnrolButton,
            Components::ContentBlocks::FileLink,
            Components::Buttons::NcceButton,
            Components::ContentBlocks::LinkedPicture,
            Components::ContentBlocks::LinkWithIcon,
            Components::ContentBlocks::TextBlock
          ]

          def self.embed(_name)
            <<~GRAPHQL.freeze
              slug
              title
              showHeadingLine
              #{SharedFields.image_fields(:titleIcon)}
              #{SharedFields.icon_block(:asideIcons)}
              content {
                __typename
                #{CONTENT_COMPONENTS.map(&:fragment).join("\n")}
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
