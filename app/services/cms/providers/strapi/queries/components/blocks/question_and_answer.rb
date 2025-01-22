module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class QuestionAndAnswer < BaseComponentQuery
              def self.name = "ComponentBlocksQuestionAndAnswer"

              def self.base_fields
                <<~GRAPHQL.freeze
                  question
                  answer
                  asideAlignment
                  showBackgroundTriangle
                  #{SharedFields.aside_sections(:asideSections)}
                  #{SharedFields.icon_block(:answerIcons)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
