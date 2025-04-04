module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class QuestionAndAnswer < StrapiMock
              strapi_component "blocks.question-and-answer"

              attribute(:question) { Faker::Lorem.sentence }
              attribute(:answer) { Text::RichBlocks.generate_data }
              attribute(:asideSections) { Collections::AsideSection.generate_aside_list }
              attribute(:answerIcons) { [] }
              attribute(:asideAlignment) { :top }
              attribute(:showBackgroundTriangle) { false }

              def self.as_model
                Factories::ComponentFactory.to_question_and_answer(generate_data)
              end
            end
          end
        end
      end
    end
  end
end
