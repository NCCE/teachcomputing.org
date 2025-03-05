module Cms
  module Providers
    module Strapi
      module Mocks
        class PrimaryGlossaryTableItems < StrapiMock
          attribute(:term) { Faker::Lorem.word }
          attribute(:keyStage) { Faker::Lorem.word }
          attribute(:definition) { RichBlocks.generate_data }
        end
      end
    end
  end
end
