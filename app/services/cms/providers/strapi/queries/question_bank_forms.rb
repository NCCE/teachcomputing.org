module Cms
  module Providers
    module Strapi
      module Queries
        class QuestionBankForms
          def self.embed(name)
            <<~GRAPHQL.freeze
              #{Components::ContentBlocks::QuestionBankForm.embed(name)}
            GRAPHQL
          end
        end
      end
    end
  end
end
