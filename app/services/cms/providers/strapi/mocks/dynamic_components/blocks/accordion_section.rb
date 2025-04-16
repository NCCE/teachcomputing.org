module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class AccordionSection < StrapiMock
              strapi_component "blocks.accordion-section"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:bkColor) { nil }
              attribute(:accordionBlocks) { Array.new(2) { ContentBlocks::AccordionBlock.generate_data } }
              attribute(:id) { 1 }
            end
          end
        end
      end
    end
  end
end
