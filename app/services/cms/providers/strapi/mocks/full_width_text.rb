module Cms
  module Providers
    module Strapi
      module Mocks
        class FullWidthText
          def self.as_model
            Factories::ComponentFactory.process_component(generate_data)
          end

          def self.generate_data
            {
              content: RichBlocks.generate_data
            }
          end

          def self.generate_raw_data
            {
              __component: "blocks.full-width-text",
              id: 1
            }.merge(generate_data)
          end
        end
      end
    end
  end
end
