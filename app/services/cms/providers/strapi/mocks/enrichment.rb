module Cms
  module Providers
    module Strapi
      module Mocks
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

        class EnrichmentType < StrapiMock
          attribute(:name) { Faker::Lorem.word }
          attribute(:logo) { Mocks::Image.generate_raw_data }
        end
      end
    end
  end
end
