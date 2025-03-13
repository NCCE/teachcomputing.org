module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class VideoCard < BaseComponentQuery
              def self.name = "ComponentContentBlocksVideoCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  videoUrl
                  title
                  name
                  jobTitle
                  textContent
                  #{SharedFields.color_theme(:colorTheme)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
