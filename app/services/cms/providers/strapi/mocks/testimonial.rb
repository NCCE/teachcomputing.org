module Cms
  module Providers
    module Strapi
      module Mocks
        class Testimonial < StrapiMock
          strapi_component "content-blocks.testimonial"

          attribute(:name) { Faker::Name.name }
          attribute(:jobTitle) { Faker::Job.title }
          attribute(:avatar) { {data: ImageComponents::Image.generate_raw_data} }
          attribute(:quote) { TextComponents::RichBlocks.generate_data }
        end
      end
    end
  end
end
