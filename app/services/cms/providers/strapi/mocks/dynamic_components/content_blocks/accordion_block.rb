module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class AccordionBlock < StrapiMock
              strapi_component "content-blocks.accordion-block"

              attribute(:heading) { Faker::Lorem.word }
              attribute(:summaryText) { Faker::Lorem.sentence }
              attribute(:textContent) { Text::RichBlocks.generate_data }
            end
          end
        end
      end
    end
  end
end
