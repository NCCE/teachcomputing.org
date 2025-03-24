module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class SecondaryQuestionBank < StrapiMock
              strapi_component "blocks.secondary-question-bank"

              attribute(:title) { Faker::Lorem.word }
            end
          end
        end
      end
    end
  end
end
