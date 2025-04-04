module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class EmbeddedVideo < StrapiMock
              strapi_component "content-blocks.embedded-video"

              attribute(:url) { "https://static.teachcomputing.org/How_important_is_the_I_Belong_programme.mp4" }
            end
          end
        end
      end
    end
  end
end
