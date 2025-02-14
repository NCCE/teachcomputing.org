module Cms
  module Providers
    module Strapi
      module Mocks
        class Icon
          def self.as_model
            Factories::BlocksFactory.to_icon(generate_data)
          end

          def self.generate_data
            {
              iconText: Faker::Lorem.word,
              iconImage: {data: Image.generate_raw_data}
            }
          end
        end
      end
    end
  end
end
