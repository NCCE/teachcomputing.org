module Cms
  module Providers
    module Strapi
      module Mocks
        class RichBlocks
          def self.as_model
            Factories::ModelFactory.to_content_block(generate)
          end

          def self.generate
            [paragraph(2)]
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
