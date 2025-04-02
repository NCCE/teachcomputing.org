module Cms
  module Providers
    module Strapi
      module Mocks
        class SecondaryQuestionBankTopic < StrapiMock
          attribute(:topic) { Faker::Lorem.word }
          attribute(:forms) { Array.new(2) { Cms::Mocks::DynamicComponents::ContentBlocks::QuestionBankForm.generate_data } }
        end
      end
    end
  end
end
