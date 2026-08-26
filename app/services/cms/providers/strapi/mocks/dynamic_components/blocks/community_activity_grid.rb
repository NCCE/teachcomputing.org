module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class CommunityActivityGrid < StrapiMock
              strapi_component "blocks.community-activity-list"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:intro) { Text::RichBlocks.generate_data }
              attribute(:group) { {slug: "group-slug"} }
            end
          end
        end
      end
    end
  end
end
