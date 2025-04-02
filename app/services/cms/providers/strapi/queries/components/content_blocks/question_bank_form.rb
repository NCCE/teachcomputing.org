module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class QuestionBankForm < BaseComponentQuery
              def self.name = "ComponentContentBlocksQuestionBankForm"

              def self.base_fields
                <<~GRAPHQL.freeze
                  formName
                  #{Link.embed(:links)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
