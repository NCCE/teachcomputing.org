module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module EmbedBlocks
            class SectionTitle < StrapiMock
              strapi_component "embed-blocks.section-title"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:icon) { nil }

              def as_model(key = :gridRowTitle)
                Factories::EmbedBlocksFactory.to_section_title({key => generate_data})
              end
            end
          end
        end
      end
    end
  end
end
