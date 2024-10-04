module Cms
  module Providers
    module Strapi
      module Mocks
        class NcceButton
          def self.as_model
            Factories::ComponentFactory.process_component(generate_raw_data)
          end

          def self.generate_data(aside_sections: [])
            {
              title: Faker::Lorem.word,
              link: Faker::Internet.url
            }
          end

          def self.generate_raw_data
            {
              __component: "buttons.ncce-button",
              id: 1
            }.merge(generate_data)
          end
        end
      end
    end
  end
end
