module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class QuestionBankForm < StrapiMock
              strapi_component "content-blocks.secondary-question-bank"

              attribute(:formName) { Faker::Lorem.sentence }
              attribute(:links) { Array.new(2) { Cms::Mocks::DynamicComponents::ContentBlocks::Link.as_model } }
            end
          end
        end
      end
    end
  end
end
