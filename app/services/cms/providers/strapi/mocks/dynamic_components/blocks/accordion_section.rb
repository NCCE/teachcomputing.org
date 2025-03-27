module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class AccordionSection < StrapiMock
              strapi_component "blocks.accordion-section"

              attribute(:title) { } 
              attribute(:bkColor) { } 
              attribute(:accordionBlock) { } 
            end
          end
        end
      end
    end
  end
end