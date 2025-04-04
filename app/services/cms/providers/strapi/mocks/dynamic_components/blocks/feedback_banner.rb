module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class FeedbackBanner < StrapiMock
              strapi_component "blocks.feedback-banner"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:button) { Cms::Mocks::DynamicComponents::Buttons::NcceButton.generate_data }
            end
          end
        end
      end
    end
  end
end
