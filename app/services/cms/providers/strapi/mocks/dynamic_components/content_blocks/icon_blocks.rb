module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class IconBlocks
              def self.as_model(icon_count: 1)
                Factories::BlocksFactory.to_icon_block(generate_data(icon_count:))
              end

              def self.generate_data(icon_count: 1)
                Array.new(icon_count) { Icon.generate_data }
              end
            end
          end
        end
      end
    end
  end
end
