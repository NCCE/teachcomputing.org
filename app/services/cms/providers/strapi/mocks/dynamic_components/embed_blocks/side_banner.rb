module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module EmbedBlocks
            class SideBanner < StrapiMock
              attribute(:textContent) { Text::RichBlocks.generate_data }
              attribute(:icon) { nil }
              attribute(:bannerColor) { {data: Meta::ColorScheme.generate_data(name: "orange")} }

              def self.as_model(key: :banner, **)
                Factories::EmbedBlocksFactory.to_side_banner({key => generate_data}, **)
              end
            end
          end
        end
      end
    end
  end
end
