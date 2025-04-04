module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class NumberedIconList < StrapiMock
              strapi_component "blocks.numbered-icon-list"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:titleIcon) { {data: Images::Image.generate_raw_data} }
              attribute(:points) { Array.new(2) { {textContent: Text::RichBlocks.generate_data} } }
              attribute(:asideSections) { Collections::AsideSection.generate_aside_list }
            end
          end
        end
      end
    end
  end
end
