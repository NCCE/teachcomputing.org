module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class EnrichmentPage < StrapiMock
            attribute(:pageTitle) { MetaComponents::PageTitle.generate_data }
            attribute(:seo) { MetaComponents::Seo.generate_data }
            attribute(:slug) { Faker::Internet.slug }
            attribute(:featuredSectionTitle) { Faker::Lorem.sentence }
            attribute(:allSectionTitle) { Faker::Lorem.sentence }
            attribute(:typeFilterPlaceholder) { Faker::Lorem.sentence }
            attribute(:termFilterPlaceholder) { Faker::Lorem.sentence }
            attribute(:ageGroupFilterPlaceholder) { Faker::Lorem.sentence }
            attribute(:content) { [DynamicComponents::Blocks::FullWidthBanner.generate_raw_data] }
            attribute(:enrichments) { {data: Array.new(5) { Collections::Enrichment.generate_raw_data }} }
          end
        end
      end
    end
  end
end
