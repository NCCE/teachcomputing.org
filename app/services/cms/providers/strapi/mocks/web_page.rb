module Cms
  module Providers
    module Strapi
      module Mocks
        class WebPage < StrapiMock
          attribute(:slug) { Faker::Internet.slug }
          attribute(:seo) { Seo.generate_data }
          attribute(:pageTitle) { PageTitle.generate_data }
          attribute(:pageContent) { [] }
        end
      end
    end
  end
end
