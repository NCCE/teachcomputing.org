module Cms
  module Providers
    module Strapi
      module Mocks
        class EmailTemplate < StrapiMock
          attribute(:subject) { Faker::Lorem.sentence }
          attribute(:slug) { Faker::Internet.slug }
          attribute(:emailContent) { RichBlocks.generate_data }
          attribute(:ctas) { nil }
        end
      end
    end
  end
end
