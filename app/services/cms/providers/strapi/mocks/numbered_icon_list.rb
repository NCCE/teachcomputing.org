module Cms
  module Providers
    module Strapi
      module Mocks
        class NumberedIconList < StrapiMock
          strapi_component "blocks.numbered-icon-list"

          attribute(:title) { Faker::Lorem.sentence }
          attribute(:titleIcon) { {data: Mocks::Image.generate_raw_data} }
          attribute(:points) { Array.new(2) { {textContent: Mocks::RichBlocks.generate_data} } }
          attribute(:asideSections) { Mocks::AsideSection.generate_aside_list }
        end
      end
    end
  end
end
