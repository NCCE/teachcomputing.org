module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class CurriculumKeyStages < StrapiMock
              strapi_component "blocks.curriculum-key-stages"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:bkColor) { nil }
            end
          end
        end
      end
    end
  end
end
