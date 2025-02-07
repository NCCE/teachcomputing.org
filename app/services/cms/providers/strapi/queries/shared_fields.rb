module Cms
  module Providers
    module Strapi
      module Queries
        module SharedFields
          def self.by_slug(key)
            <<~GRAPHQL.freeze
              #{key} {
                data {
                  attributes {
                    slug
                  }
                }
              }
            GRAPHQL
          end

          def self.programme_slug(name = "programme")
            by_slug(name)
          end

          def self.icon_block(name)
            <<~GRAPHQL.freeze
              #{name} {
                iconText
                #{SharedFields.image_fields("iconImage")}
              }
            GRAPHQL
          end

          def self.color_theme(name)
            <<~GRAPHQL.freeze
              #{name} {
                data {
                  attributes {
                    name
                  }
                }
              }
            GRAPHQL
          end

          def self.aside_sections(name = "asideSections")
            by_slug(name)
          end

          def self.image_fields(name)
            <<~GRAPHQL.freeze
              #{name} {
                data {
                  id
                  attributes {
                    name
                    alternativeText
                    caption
                    width
                    height
                    formats
                    hash
                    ext
                    mime
                    size
                    url
                    previewUrl
                    provider
                    provider_metadata
                    createdAt
                    updatedAt
                  }
                }
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
