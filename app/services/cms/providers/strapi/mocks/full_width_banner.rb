module Cms
  module Providers
    module Strapi
      module Mocks
        class FullWidthBanner
          def self.as_model
            Factories::ComponentFactory.process_component(generate_data)
          end

          def self.generate_data(aside_sections: [])
            {
              textContent: RichBlocks.generate,
              image: nil
            }
          end

          def self.generate_raw_data
            {
              __component: "blocks.full-width-banner",
              id: 1
            }.merge(generate_data)
          end
        end
      end
    end
  end
end
