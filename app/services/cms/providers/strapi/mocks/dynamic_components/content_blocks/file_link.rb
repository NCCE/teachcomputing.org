module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class FileLink < StrapiMock
              strapi_component "content-blocks.file-link"

              attribute(:file) { {data: File.generate_raw_data} }
            end

            class File < StrapiMock
              attribute(:url) { Faker::Internet.slug }
              attribute(:filename) { "test.pdf" }
              attribute(:size) { 50 }
              attribute(:updatedAt) { Faker::Date.backward.to_s }
            end
          end
        end
      end
    end
  end
end
