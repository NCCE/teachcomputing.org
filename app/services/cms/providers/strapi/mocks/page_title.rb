module Cms
  module Providers
    module Strapi
      module Mocks
        class PageTitle
          def self.as_model(key: nil)
            Factories::ModelFactory.process_model(
              {model: Models::PageTitle, key:},
              generate_data
            )
          end

          def self.generate_data(intro_text: nil)
            {
              title: Faker::Lorem.words(number: 5),
              introText: intro_text
            }
          end

          def self.generate_raw_data
            {
              id: Faker::Number.number
            }.merge(generate_data)
          end
        end
      end
    end
  end
end
