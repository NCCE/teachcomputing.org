module Cms
  module Providers
    module Strapi
      module Mocks
        class QuestionAndAnswer
          def self.as_model
            Factories::ComponentFactory.to_question_and_answer(generate_data)
          end

          def self.generate_data(aside_sections: [])
            {
              question: Faker::Lorem.sentence,
              answer: RichBlocks.generate,
              asideSections: aside_sections
            }
          end

          def self.generate_raw_data
            {
              __component: "blocks.question-and-answer",
              id: 1,
              attributes: generate_data
            }
          end
        end
      end
    end
  end
end
