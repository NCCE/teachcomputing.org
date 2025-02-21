module Cms
  module Providers
    module Strapi
      module Mocks
        class RichBlocks
          def self.single_line(text)
            [
              {
                type: "paragraph",
                children: [{text:, type: "text"}]
              }
            ]
          end

          def self.as_model(with_wrapper: false)
            Factories::ModelFactory.to_content_block(generate_data, with_wrapper:)
          end

          def self.generate_data
            [paragraph(6)]
          end

          def self.paragraph(sentences)
            {
              type: "paragraph",
              children: Faker::Lorem.sentences(number: sentences).map { {text: _1, type: "text"} }
            }
          end
        end
      end
    end
  end
end
