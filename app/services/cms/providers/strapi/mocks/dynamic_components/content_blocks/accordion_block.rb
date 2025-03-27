module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class AccordionBlock < StrapiMock
              strapi_component "blocks.accordion-block"

              attribute(:heading) { } 
              attribute(:summaryText) { } 
              attribute(:content) { } 
            end
          end
        end
      end
    end
  end
end