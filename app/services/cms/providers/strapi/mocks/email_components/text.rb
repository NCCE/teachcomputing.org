module Cms
  module Providers
    module Strapi
      module Mocks
        module EmailComponents
          class Text < StrapiMock
            strapi_component "email-content.text"
            attribute(:textContent) { RichBlocks.generate_data }
          end
        end
      end
    end
  end
end
