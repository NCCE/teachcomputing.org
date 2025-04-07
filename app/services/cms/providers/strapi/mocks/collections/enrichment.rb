module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class Enrichment < StrapiMock
            attribute(:i_belong) { true }
            attribute(:link) { nil }
            attribute(:featured) { false }
            attribute(:rich_title) { Text::RichBlocks.generate_data }
            attribute(:rich_details) { Text::RichBlocks.generate_data }
            attribute(:terms) { {data: Array.new(1) { Collections::EnrichmentCategory.generate_raw_data }} }
            attribute(:age_groups) { {data: Array.new(2) { Collections::EnrichmentCategory.generate_raw_data }} }
            attribute(:type) { {data: Collections::EnrichmentType.generate_raw_data} }
            attribute(:partner_icon) { Images::Image.generate_raw_data }
          end
        end
      end
    end
  end
end
