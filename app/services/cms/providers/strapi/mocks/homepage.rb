module Cms
  module Providers
    module Strapi
      module Mocks
        class Homepage < StrapiMock
          attribute(:seo) { MetaComponents::Seo.generate_data }
          attribute(:content) {
            [
              DynamicComponents::Blocks::HomepageHero.generate_raw_data
            ]
          }
        end
      end
    end
  end
end
