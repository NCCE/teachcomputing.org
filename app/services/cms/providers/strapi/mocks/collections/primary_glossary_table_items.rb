module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class PrimaryGlossaryTableItems < StrapiMock
            attribute(:term) { Faker::Lorem.word }
            attribute(:keyStage) { Faker::Lorem.word }
            attribute(:definition) { TextComponents::RichBlocks.generate_data }
          end
        end
      end
    end
  end
end
