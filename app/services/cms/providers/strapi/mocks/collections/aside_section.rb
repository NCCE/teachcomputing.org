module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class AsideSection < StrapiMock
            attribute(:slug) { Faker::Internet.slug }
            attribute(:title) { Faker::Lorem.sentence }
            attribute(:content) { [Text::TextBlock.generate_raw_data] }
            attribute(:showHeadingLine) { true }
            attribute(:asideIcons) { [] }

            def self.generate_aside_list(aside_slugs: [])
              aside_slugs.map! do |slug|
                {
                  id: Faker::Number.number,
                  slug:
                }
              end
              {data: aside_slugs.map { {attributes: _1} }}
            end
          end
        end
      end
    end
  end
end
