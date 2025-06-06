module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class HorizontalLinkCard < StrapiMock
              strapi_component "content-blocks.horizontal-link-card"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:linkUrl) { Faker::Internet.url }
              attribute(:cardContent) { Text::RichBlocks.generate_data }
              attribute(:theme) { {data: Meta::ColorScheme.generate_data} }
            end
          end
        end
      end
    end
  end
end
