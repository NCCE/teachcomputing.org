module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          class CommunityActivityList < StrapiMock
            strapi_component "blocks.community-activity-list"

            attribute(:title) { Faker::Lorem.sentence }
            attribute(:intro) { RichBlocks.generate_data }
            attribute(:programmeActivityGroupSlug) { "primary-certificate" }
          end
        end
      end
    end
  end
end
