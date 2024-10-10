module Cms
  module Providers
    module Strapi
      module Mocks
        class EnrichmentPage < StrapiMock
          attribute(:pageTitle) { PageTitle.generate_raw_data }
          attribute(:seo) { Seo.generate_raw_data }
          attribute(:slug) { Faker::Internet.slug }
          attribute(:featuredSectionTitle) { Faker::Lorem.sentence }
          attribute(:allSectionTitle) { Faker::Lorem.sentence }
          attribute(:typeFilterPlaceholder) { Faker::Lorem.sentence }
          attribute(:termFilterPlaceholder) { Faker::Lorem.sentence }
          attribute(:ageGroupFilterPlaceholder) { Faker::Lorem.sentence }
          attribute(:content) { [Cms::Mocks::FullWidthBanner.generate_raw_data] }
          attribute(:enrichments) { {data: Array.new(5) { Enrichment.generate_raw_data }} }
        end

        class Enrichment < StrapiMock
          attribute(:i_belong) { true }
          attribute(:link) { nil }
          attribute(:featured) { false }
          attribute(:rich_title) { Mocks::RichBlocks.generate_data }
          attribute(:rich_details) { Mocks::RichBlocks.generate_data }
          attribute(:terms) { {data: Array.new(1) { EnrichmentCategory.generate_raw_data }} }
          attribute(:age_groups) { {data: Array.new(2) { EnrichmentCategory.generate_raw_data }} }
          attribute(:type) { {data: EnrichmentType.generate_raw_data} }
          attribute(:partner_icon) { Mocks::Image.generate_raw_data }
        end

        class EnrichmentCategory < StrapiMock # For terms and age groups
          attribute(:name) { Faker::Lorem.word }
        end

        class EnrichmentType < StrapiMock # For terms and age groups
          attribute(:name) { Faker::Lorem.word }
          attribute(:name) { Mocks::Image.generate_raw_data }
        end
      end
    end
  end
end
