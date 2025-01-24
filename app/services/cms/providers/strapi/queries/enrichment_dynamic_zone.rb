module Cms
  module Providers
    module Strapi
      module Queries
        class EnrichmentDynamicZone
          ENRICHMENT_COMPONENTS = [
            Components::Blocks::TextWithAsides
          ]

          def self.embed(name)
            <<~GRAPHQL.freeze
              #{name} {
                __typename
                #{ENRICHMENT_COMPONENTS.map(&:fragment).join("\n")}
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
