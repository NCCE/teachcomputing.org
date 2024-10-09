module Cms
  module Providers
    module Strapi
      module Mocks
        class Seo
          def self.as_model(key: nil)
            Factories::ModelFactory.process_model(
              {model: Models::Seo, key:},
              generate_data
            )
          end

          def self.generate_data(title: nil, description: nil)
            {
              title: title.presence || Faker::Lorem.words(number: 5),
              description: description.presence || Faker::Lorem.paragraphs(number: 2),
              featured_image: nil
            }
          end

          def self.generate_raw_data(title: nil, description: nil)
            {
              id: Faker::Number.number
            }.merge(generate_data(title:, description:))
          end
        end
      end
    end
  end
end
