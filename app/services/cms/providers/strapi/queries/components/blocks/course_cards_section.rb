module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class CourseCardsSection < BaseComponentQuery
              def self.name = "ComponentBlocksCourseCardsSection"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  introText
                  #{ContentBlocks::CourseCard.embed(:cards)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
