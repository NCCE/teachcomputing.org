module Cms
  module Providers
    module Strapi
      module Mocks
        class EnrichmentPage
          def self.generate_data(slug:)
            {
              pageTitle: PageTitle.generate_raw_data,
              seo: Seo.generate_raw_data,
              slug:,
              featuredSectionTitle: Faker::Lorem.sentence,
              allSectionTitle: Faker::Lorem.sentence,
              typeFilterPlaceholder: Faker::Lorem.sentence,
              termFilterPlaceholder: Faker::Lorem.sentence,
              ageGroupFilterPlaceholder: Faker::Lorem.sentence,
              content: [
                Cms::Mocks::FullWidthBanner.generate_raw_data
              ],
              enrichments: {
                data: Array.new(5) { Enrichment.generate_raw_data }
              },
              publishedAt: Faker::Date.backward,
              createdAt: Faker::Date.backward,
              updatedAt: Faker::Date.backward
            }
          end

          def self.generate_raw_data(slug:)
            {
              id: Faker::Number.number,
              attributes: generate_data(slug:)
            }
          end
        end
      end

      class Enrichment
        def self.generate_data
          {
            i_belong: true,
            link: nil,
            featured: false,
            rich_title: Mocks::RichBlocks.generate_data,
            rich_details: Mocks::RichBlocks.generate_data,
            terms: {data: Array.new(1) { EnrichmentCategory.generate_raw_data }},
            age_groups: {data: Array.new(2) { EnrichmentCategory.generate_raw_data }},
            type: {data: EnrichmentType.generate_raw_data},
            partner_icon: Mocks::Image.generate_raw_data
          }
        end

        def self.generate_raw_data
          {
            id: Faker::Number.number,
            attributes: generate_data
          }
        end
      end
    end

    class EnrichmentCategory # For terms and age groups
      def self.generate_data
        {
          name: Faker::Lorem.word
        }
      end

      def self.generate_raw_data
        {
          id: Faker::Number.number,
          attributes: generate_data
        }
      end
    end

    class EnrichmentType
      def self.generate_data
        {
          name: Faker::Lorem.word,
          icon: Mocks::Image.generate_raw_data
        }
      end

      def self.generate_raw_data
        {
          id: Faker::Number.number,
          attributes: generate_data
        }
      end
    end
  end
end
