module Cms
  module Providers
    module Strapi
      module Mocks
        class Seo < StrapiMock
          attribute(:title) { Faker::Lorem.words(number: 5) }
          attribute(:description) { Faker::Lorem.paragraphs(number: 2) }
          attribute(:featured_image) { nil }

          def self.as_model(key: nil)
            Factories::ModelFactory.process_model(
              {model: Models::Seo, key:},
              generate_data
            )
          end
        end
      end
    end
  end
end
