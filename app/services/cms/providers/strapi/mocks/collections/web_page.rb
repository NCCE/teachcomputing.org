module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class WebPage < StrapiMock
            attribute(:slug) { Faker::Internet.slug }
            attribute(:seo) { MetaComponents::Seo.generate_data }
            attribute(:pageTitle) { MetaComponents::PageTitle.generate_data }
            attribute(:pageContent) { [] }
          end
        end
      end
    end
  end
end
