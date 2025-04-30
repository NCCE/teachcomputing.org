module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class ProgrammeResourceCard < StrapiMock
              strapi_component "blocks.programme-resource-card"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:loggedOutTextContent) { Mocks::Text::RichBlocks.generate_data }
              attribute(:notEnrolledTextContent) { Mocks::Text::RichBlocks.generate_data }
              attribute(:enrolledTextContent) { Mocks::Text::RichBlocks.generate_data }
              attribute(:loggedOutButtonText) { Faker::Lorem.sentence }
              attribute(:loggedInButtonText) { Faker::Lorem.sentence }
              attribute(:clr) { {data: Meta::ColorScheme.generate_data(name: "i-belong")} }
            end
          end
        end
      end
    end
  end
end
