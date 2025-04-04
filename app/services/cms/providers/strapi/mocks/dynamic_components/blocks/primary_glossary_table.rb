module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class PrimaryGlossaryTable < StrapiMock
              strapi_component "blocks.primary-glossary-table"

              attribute(:title) { Faker::Lorem.sentence }
            end
          end
        end
      end
    end
  end
end
