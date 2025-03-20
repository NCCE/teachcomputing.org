module Cms
  module Providers
    module Strapi
      module Queries
        class QuestionBankForms
          def self.embed(_name)
            <<~GRAPHQL.freeze
              #{QuestionBankForm.embed(:forms)}
            GRAPHQL
          end
        end
      end
    end
  end
end
