module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class WebPage < StrapiMock
            attribute(:slug) { Faker::Internet.slug }
            attribute(:seo) { Meta::Seo.generate_data }
            attribute(:pageTitle) { Meta::PageTitle.generate_data }
            attribute(:pageContent) { [] }
          end
        end
      end
    end
  end
end
