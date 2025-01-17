module Cms
  module Providers
    module Strapi
      module Queries
        class Aside
          CONTENT_COMPONENTS = [
            Components::ContentBlocks::TextBlock,
            Components::ContentBlocks::LinkedPicture
          ]

          def self.fields(_name)
            <<~GRAPHQL.freeze
              slug
              title
              showHeadingLine
              #{SharedFields.image_fields(:titleIcon)}
              #{SharedFields.icon_block(:asideIcons)}
              content {
                __typename
                #{CONTENT_COMPONENTS.map(&:fields).join("\n")}
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
